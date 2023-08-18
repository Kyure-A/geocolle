import 'package:geocolle/models/lang.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class User {
  String? id;
  String? name;
  String? like;
  String? dislike;
  String? from;

  User({
    this.id,
    this.name,
    this.like,
    this.dislike,
    this.from,
  });
}

final userProvider = StateProvider<User>((ref) => User());
