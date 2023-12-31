import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';

import 'pages/collection.dart';
import 'pages/map.dart';
import 'pages/setting.dart';
import 'pages/login.dart';
import 'models/router.dart';
import 'models/user.dart';
import 'models/title.dart';

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
    Login(),
  ];

  void onTabTapped(int index) {
    if (index == Pages.setting.index) {
      ref.read(titleProvider.notifier).state = "Setting";
    } else if (index == Pages.collection.index) {
      ref.read(titleProvider.notifier).state = "好きな言語";
    }
    ref.read(pagesProvider.notifier).state = Pages.values[index];
  }

  @override
  Widget build(BuildContext context) {
    Pages pages = ref.watch(pagesProvider);
    User user = ref.watch(userProvider);
    String title = ref.watch(titleProvider);

    if (user.id == null && pages != Pages.login) {
      pages = Pages.login;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeoColle',
      theme: ThemeData(
        primaryColorLight: const Color(0xFFD4E3F8),
        primaryColorDark: const Color(0xFF8BAADA),
        unselectedWidgetColor: const Color(0xFF797785),
      ),
      home: Scaffold(
        appBar: pages == Pages.collection || pages == Pages.setting
            ? AppBar(
                title: Text(title),
                backgroundColor: Colors.white,
                foregroundColor: ThemeData().unselectedWidgetColor,
                elevation: 0.0,
                toolbarHeight: 50,
              )
            : null,
        body: p[pages.index],
        bottomNavigationBar: pages == Pages.login
            ? null
            : BottomNavigationBar(
                selectedItemColor: ThemeData().primaryColorDark,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/collection.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/collection_active.svg'),
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
