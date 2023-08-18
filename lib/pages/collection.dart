import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:geocolle/components/collect_item.dart';
import 'package:geocolle/models/user.dart';
import 'package:geocolle/models/lang.dart';
import 'package:geocolle/models/user_collection.dart';

class Collection extends StatefulHookConsumerWidget {
  const Collection({super.key});

  @override
  CollectionState createState() => CollectionState();
}

class CollectionState extends ConsumerState<Collection> {
  Future<Map<String, int>> content() async {
    Map<String, int> content = {};
    try {
      var jsonRes = await http.get(
        Uri.https(FlutterConfig.get('API_ENDPOINT'),
            "info/${ref.read(userProvider).id}"),
      );

      if (jsonRes.statusCode == 200) {
        var res = jsonDecode(jsonRes.body);
        content = res['likeCollection'].cast<String, int>();
      }
    } catch (e) {
      print(e);
    }
    return content;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () => setState(() {}),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(48, 48)),
          ),
          child: const Icon(Icons.arrow_back_ios),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: FutureBuilder<Map<String, int>>(
              future: content(),
              builder: (context, snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 48,
                    children: languagesList.entries
                        .map(
                          (e) => Center(
                            child: CollectItem(
                              name: e.key,
                              image: e.value,
                              rate: snapshot.data![e.key] ?? 0,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() {}),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(48, 48)),
          ),
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
