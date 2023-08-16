import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Collection extends StatefulHookConsumerWidget {
  const Collection({super.key});

  @override
  CollectionState createState() => CollectionState();
}

class CollectionState extends ConsumerState<Collection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: const Text('This is Collection page.'),
      ),
    );
  }
}
