import 'package:flutter/material.dart';
import 'package:geocolle/models/prefecture.dart';
import 'package:geocolle/models/user_collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void getData() async {
    try {
      var jsonRespose = await http.post(
        Uri.https(FlutterConfig.get('API_ENDPOINT'), "info"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'id': _id,
          'name': _name,
          'like': _likeLanguage!,
          'dislike': _dislikeLanguage!,
          'from': _from!,
        }),
      );

      if (jsonRespose.statusCode == 200) {
        var response = jsonDecode(jsonRespose.body);
        ref.read(userProvider.notifier).state = User(
          id: response['id'],
          name: response['name'],
          like: response['like'],
          dislike: response['dislike'],
          from: response['from'],
        );

        var jsonResponse = await http.get(
          Uri.https(
              FlutterConfig.get('API_ENDPOINT'), "info/${response['id']}"),
        );

        response = jsonDecode(jsonResponse.body);

        Map<String, int> like = {};
        response['likeCollection'].forEach((key, value) {
          like[key] = value;
        });

        ref.read(userCollectionProvider.notifier).state = UserCollection(
          like: like,
          dislike: {},
          from: {},
        );

        ref.read(pagesProvider.notifier).state = Pages.map;
      }
    } catch (e) {}
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
                getData();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
