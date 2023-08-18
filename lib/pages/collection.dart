import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/components/collectItem.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('左'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 48,
              children: List.generate(50, (index) {
                return Center(
                  child: CollectItem(
                    name: 'KyureAScript',
                    image:
                        'https://raw.githubusercontent.com/Kyure-A/avatar/master/kyure_a.jpg',
                    rate: 2 * index,
                  ),
                );
              }),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('右'),
        ),
      ],
    );
  }
}
