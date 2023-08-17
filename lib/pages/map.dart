import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_config/flutter_config.dart';

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

  static const CameraPosition _sample = CameraPosition(
    target: LatLng(35.68399266008331, 139.75461790843423),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _sample,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationButtonEnabled: false,
          ),
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
                        backgroundImage: NetworkImage('https://raw.githubusercontent.com/Kyure-A/avatar/master/kyure_a.jpg'),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 25, right: 40, left: 40),
                        child: Column(
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                              ),
                              "Kyure_A",
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                // はみでるので切り捨てたい
                                Text("Lon: 35.684"),
                                SizedBox(width: 10),
                                Text("Lat: 139.76")
                              ],
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      )
    );
  }
}