import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Map extends StatefulHookConsumerWidget {
  const Map({super.key});

  @override
  MapState createState() => MapState();
}

class MapState extends ConsumerState<Map> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: const Text('This is Map page.'),
      ),
    );
  }
}
