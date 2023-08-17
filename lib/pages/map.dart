import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  FlutterConfig.get('API_KEY');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const LatLng defaultLocation = LatLng(35.68399266008331, 139.75461790843423); // 皇居
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            StreamBuilder(
              stream: getCurrentPositionStream(),
              builder:  (BuildContext context, AsyncSnapshot<LatLng> response) {
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
                    Positioned.fill(child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, right: 20, left: 20),

                        child: Container(
                          height: 100,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://raw.githubusercontent.com/Kyure-A/avatar/master/kyure_a.jpg'),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 15, right: 40, left: 60),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),
                                        "@username",
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        style: TextStyle(
                                          color: Colors.grey
                                        ),
                                          "Lat: "
                                      ),
                                      Text(
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),
                                          "Lon: "
                                      ),// 動的にかえる
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                );
              },
            ),
          ],
        ),
    );
  }

  Stream<LatLng> getCurrentPositionStream() async* {
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

      yield LatLng(currentLatitude, currentLongitude);

      // Add a delay before checking for the next position update
      await Future.delayed(Duration(seconds: 1));
    }
  }

}