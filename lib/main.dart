import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pages/collection.dart';
import 'pages/map.dart';
import 'pages/setting.dart';
import 'models/router.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  static const p = [
    Setting(),
    Map(),
    Collection(),
  ];

  void onTabTapped(int index) {
    ref.read(pagesProvider.notifier).state = Pages.values[index];
  }

  @override
  Widget build(BuildContext context) {
    Pages pages = ref.watch(pagesProvider);

    return MaterialApp(
      title: 'GeoColle',
      theme: ThemeData(
        primaryColor: const Color(0xFFD4E3F8),
        primaryColorDark: const Color(0xFF8BAADA),
      ),
      home: Scaffold(
        body: p[pages.index],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ThemeData().primaryColorDark,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/collection.svg'),
              activeIcon: SvgPicture.asset('assets/collection_active.svg'),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/map.svg'),
              activeIcon: SvgPicture.asset('assets/map_active.svg'),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/setting.svg'),
              activeIcon: SvgPicture.asset('assets/setting_active.svg'),
              label: 'Setting',
            ),
          ],
          currentIndex: pages.index,
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
