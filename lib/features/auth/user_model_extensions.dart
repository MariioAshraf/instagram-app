import 'models/user_model.dart';

extension UserModelExtension on UserModel {
  bool get hasProfileImage =>
      profileImageUrl != null && profileImageUrl!.isNotEmpty;

  bool get hasCoverImage => coverImageUrl != null && coverImageUrl!.isNotEmpty;

  bool get hasBio => bio != null && bio!.isNotEmpty;

  UserModel copyWith({
    String? name,
    String? uId,
    String? profileImageUrl,
    String? coverImageUrl,
    String? bio,
    String? viewStoryAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      uId: uId ?? this.uId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      bio: bio ?? this.bio,
      viewStoryAt: viewStoryAt ?? viewStoryAt,
    );
  }
}
