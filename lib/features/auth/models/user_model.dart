import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  late final String name;

  @HiveField(1)
  String? uId;

  @HiveField(2)
  String? profileImageUrl;

  @HiveField(3)
  String? coverImageUrl;

  @HiveField(4)
  String? bio;

  @HiveField(5)
  String? viewStoryAt;

  UserModel({
    required this.name,
    this.uId,
    this.profileImageUrl = '',
    this.coverImageUrl = '',
    this.bio = '',
    this.viewStoryAt,
  });

  UserModel.fromJson(json) {
    name = json['name'] as String;
    uId = json['uId'] as String;
    profileImageUrl = json['profileImage'] as String;
    coverImageUrl = json['coverImage'] as String;
    bio = json['bio'] as String;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'profileImage': profileImageUrl,
      'coverImage': coverImageUrl,
      'bio': bio,
    };
  }
}
