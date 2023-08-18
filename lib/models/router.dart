import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Pages {
  collection,
  map,
  setting,
  login,
}

final pagesProvider = StateProvider<Pages>((ref) => Pages.login);
