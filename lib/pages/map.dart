import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:geocolle/models/user.dart';

class Map extends StatefulHookConsumerWidget {
  const Map({super.key});

  @override
  MapState createState() => MapState();
}

class MapState extends ConsumerState<Map> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng defaultLocation =
      LatLng(35.68399266008331, 139.75461790843423); // 皇居
  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider);

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            stream: getCurrentPositionStream(user.id!),
            builder: (BuildContext context, AsyncSnapshot<LatLng> response) {
              if (response.hasError) {
                return Text("Error: ${response.error}");
              }

              if (!response.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Stack(
                children: [
                  // Google Map は奥に配置されてほしい
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: response.data ?? defaultLocation, zoom: 17.0),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationButtonEnabled: false,
                  ),
                  // なんか名前とか表示される bar は後
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, right: 20, left: 20),
                        child: Container(
                          height: 100,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    'https://github.com/${user.name}.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 40,
                                  left: 60,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      "@${user.id}",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      "Lat: ${response.data!.latitude.toStringAsFixed(5)}",
                                    ),
                                    Text(
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      "Lon: ${response.data!.longitude.toStringAsFixed(5)}",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void postLocation(double lat, double lon, String userID) async {
    try {
      var jsonResponse = await http.post(
        Uri.https(FlutterConfig.get('API_ENDPOINT'), "pos"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'id': userID,
          'lat': lat.toInt(),
          'lon': lon.toInt(),
        }),
      );
      print(jsonResponse.body);
    } catch (e) {
      print(e);
    }
  }

  Stream<LatLng> getCurrentPositionStream(String userID) async* {
    var count = 0;
    while (true) {
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission;

      if (!isEnabled) {
        yield* Stream.error('位置情報の権限が無効になっています．');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          yield* Stream.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        yield* Stream.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position currentPosition = await Geolocator.getCurrentPosition();
      double currentLatitude = currentPosition.latitude;
      double currentLongitude = currentPosition.longitude;
      if (count >= 5) {
        postLocation(currentLatitude, currentLongitude, userID);
        count = 0;
      } else {
        count++;
      }

      yield LatLng(currentLatitude, currentLongitude);

      // Add a delay before checking for the next position update
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
