import 'package:flutter/material.dart';
import 'package:geocolle/models/lang.dart';
import 'package:geocolle/models/prefecture.dart';
import 'package:geocolle/models/user_collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/components/collect_item.dart';
import 'package:geocolle/models/title.dart';

class Collection extends StatefulHookConsumerWidget {
  const Collection({super.key});

  @override
  CollectionState createState() => CollectionState();
}

class CollectionState extends ConsumerState<Collection> {
  int pageCounter = 2;

  void setPageTitle() {
    switch (pageCounter) {
      case 0:
        ref.read(titleProvider.notifier).state = "好きな言語";
        break;
      case 1:
        ref.read(titleProvider.notifier).state = "嫌いな言語";
        break;
      case 2:
        ref.read(titleProvider.notifier).state = "出身地";
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserCollection userCollection = ref.watch(userCollectionProvider);

    var page = [
      languagesList.entries
          .map((e) => Center(
                child: CollectItem(
                  name: e.key,
                  image: e.value,
                  rate: userCollection.like[e.key] ?? 0,
                ),
              ))
          .toList(),
      languagesList.entries
          .map(
            (e) => Center(
              child: CollectItem(
                name: e.key,
                image: e.value,
                rate: userCollection.dislike[e.key] ?? 0,
              ),
            ),
          )
          .toList(),
      prefectureList.entries
          .map(
            (e) => Center(
              child: CollectItem(
                name: e.key,
                image: e.value,
                rate: userCollection.from[e.key] ?? 0,
              ),
            ),
          )
          .toList(),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () => setState(() {
            pageCounter == 0 ? pageCounter = 2 : pageCounter--;
            setPageTitle();
          }),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(48, 48)),
          ),
          child: const Icon(Icons.arrow_back_ios),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 48,
              children: page[pageCounter],
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() {
            pageCounter == 2 ? pageCounter = 0 : pageCounter++;
            setPageTitle();
          }),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(48, 48)),
          ),
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
