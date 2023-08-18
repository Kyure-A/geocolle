import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';

import 'pages/collection.dart';
import 'pages/map.dart';
import 'pages/setting.dart';
import 'models/router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  FlutterConfig.get('API_KEY');
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
    Collection(),
    Map(),
    Setting(),
  ];

  void onTabTapped(int index) {
    ref.read(pagesProvider.notifier).state = Pages.values[index];
  }

  @override
  Widget build(BuildContext context) {
    Pages pages = ref.watch(pagesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeoColle',
      theme: ThemeData(
        primaryColor: const Color(0xFFD4E3F8),
        primaryColorDark: const Color(0xFF8BAADA),
        unselectedWidgetColor: const Color(0xFF797785),
      ),
      home: Scaffold(
        appBar: pages == Pages.collection
            ? AppBar(
                title: const Text('Collection'),
                backgroundColor: Colors.white,
                foregroundColor: ThemeData().unselectedWidgetColor,
                elevation: 0.0,
                toolbarHeight: 50,
              )
            : null,
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
