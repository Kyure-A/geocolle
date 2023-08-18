import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:geocolle/models/router.dart';
import 'package:geocolle/models/user.dart';

class Login extends StatefulHookConsumerWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  String _id = "";

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
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).state = User(id: _id);
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
