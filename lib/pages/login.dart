import 'package:flutter/material.dart';
import 'package:geocolle/models/prefecture.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/models/lang.dart';
import 'package:geocolle/models/router.dart';
import 'package:geocolle/models/user.dart';

class Login extends StatefulHookConsumerWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  String _id = "";
  String _name = "";
  String? _from = prefectureList.keys.first;
  String? _likeLanguage = languagesList.keys.first;
  String? _dislikeLanguage = languagesList.keys.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            TextField(
              enabled: true,
              maxLength: 20,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'ID',
              ),
              onChanged: (String value) {
                _id = value;
              },
            ),
            TextField(
              enabled: true,
              maxLength: 20,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (String value) {
                _name = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('出身地'),
                DropdownButton(
                  items: prefectureList.entries
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.key,
                          child: Text(e.key),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _from = value;
                    });
                  },
                  value: _from,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('好きな言語'),
                DropdownButton(
                  items: languagesList.entries
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.key,
                          child: Text(e.key),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _likeLanguage = value;
                    });
                  },
                  value: _likeLanguage,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('嫌いな言語'),
                DropdownButton(
                  items: languagesList.entries
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.key,
                          child: Text(e.key),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _dislikeLanguage = value;
                    });
                  },
                  value: _dislikeLanguage,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).state = User(
                  id: _id,
                  name: _name,
                  like: _likeLanguage,
                  dislike: _dislikeLanguage,
                  from: _from,
                );
                ref.read(pagesProvider.notifier).state = Pages.map;
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
