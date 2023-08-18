import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCollection {
  final Map<String, int> like;
  final Map<String, int> dislike;
  final Map<String, int> from;

  UserCollection({
    required this.like,
    required this.dislike,
    required this.from,
  });
}

final userCollectionProvider = StateProvider<UserCollection>(
  (ref) => UserCollection(
    like: {},
    dislike: {},
    from: {},
  ),
);
