import 'package:flutter/material.dart';
import 'package:geocolle/models/lang.dart';
import 'package:geocolle/models/prefecture.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/models/user.dart';
import 'package:geocolle/models/title.dart';

class Setting extends StatefulHookConsumerWidget {
  const Setting({super.key});

  @override
  SettingState createState() => SettingState();
}

class SettingState extends ConsumerState<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile
          Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeData().unselectedWidgetColor,
            ),
            "Profile",
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://github.com/${user.name}.png',
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeData().unselectedWidgetColor,
                  ),
                  "@ ${user.id}",
                ),
              ],
            ),
          ),
          // About
          Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeData().unselectedWidgetColor,
            ),
            "About",
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 出身地
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeData().primaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("出身地"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          prefectureList[user.from]!,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                // 好きな言語
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeData().primaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("好きな言語"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          languagesList[user.like]!,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                // 嫌いな言語
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeData().primaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("嫌いな言語"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          languagesList[user.dislike]!,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeData().unselectedWidgetColor,
            ),
            "Records",
          ),
        ],
      ),
    );
  }
}
