class UserModel {
  late final String name;
  String? uId;
  String? profileImageUrl;
  String? coverImageUrl;
  String? bio;
  String? viewStoryAt;

  UserModel({
    required this.name,
    required this.uId,
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
