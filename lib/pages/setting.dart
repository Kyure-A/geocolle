import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  Map<String, String> mp = {
    "出身地" : "大阪府",
    "好きな言語" : "Emacs Lisp",
    "嫌いな言語" : "Python"
  };

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              "Profile"
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://raw.githubusercontent.com/Kyure-A/avatar/master/kyure_a.jpg'),
                ),
                SizedBox(width: 20),
                Text(
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                    "@username"
                ),
              ],
            )
          ),
          Text(
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              "About"
          ),
          Row(
            children: [
              Text("出身地",
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                  )
              ),
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage("https://illustimage.com/photo/dl/545.png?20160706"),
              )
            ],
          ),
          Row(
            children: [
              Text("好きな言語",
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                  )),
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/EmacsIcon.svg/1024px-EmacsIcon.svg.png"),
              )
            ],
          ),
          Row(
            children: [
              Text("嫌いな言語",
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(175, 230, 250, 100.0),
                  )),
              SizedBox(width: 30),
              CircleAvatar(
                backgroundImage: NetworkImage("https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/python/python.png"),
              )
            ],
          ),
          Text(
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),
              "Records"
          ), // すれ違ったら草を生やす
        ],
      ),
    );
  }
}
