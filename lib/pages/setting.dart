import 'package:flutter/material.dart';
import 'package:geocolle/models/lang.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/models/user.dart';

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
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ThemeData().unselectedWidgetColor,
            ),
            "Profile",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://raw.githubusercontent.com/Kyure-A/avatar/master/kyure_a.jpg',
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  "@${user.id}",
                ),
              ],
            ),
          ),
          const Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            "About",
          ),
          const Row(
            children: [
              Text(
                "出身地",
                style: TextStyle(
                  backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                ),
              ),
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Lisp_logo.svg/512px-Lisp_logo.svg.png",
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "好きな言語",
                style: TextStyle(
                  backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                ),
              ),
              const SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  languagesList[user.like]!,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("嫌いな言語",
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                  )),
              const SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  languagesList[user.dislike]!,
                ),
              )
            ],
          ),
          const Text(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            "Records",
          ), // すれ違ったら草を生やす
        ],
      ),
    );
  }
}
