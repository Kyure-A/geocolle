import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Pages {
  collection,
  map,
  setting,
}

final pagesProvider = StateProvider<Pages>((ref) => Pages.map);
