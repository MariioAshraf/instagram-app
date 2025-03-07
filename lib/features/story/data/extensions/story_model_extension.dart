import '../../../auth/models/user_model.dart';
import '../models/story_model.dart';

extension StoryModelExtension on StoryModel {
  StoryModel copyWith({
    String? fileUrl,
    String? caption,
    MediaType? mediaType,
    int? duration,
    String? userId,
    DateTime? createdAt,
    String? storyId,
    String? localFilePath,
    Map<String, String>? viewersIds,
    Map<String, UserModel>? viewersModels,
    UserModel? storyUserModel,
  }) {
    return StoryModel(
      storyUserModel: storyUserModel ?? this.storyUserModel,
      fileUrl: fileUrl ?? this.fileUrl,
      caption: caption ?? this.caption,
      mediaType: mediaType ?? this.mediaType,
      duration: duration ?? this.duration,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      storyId: storyId ?? this.storyId,
      seenStoryDate: viewersIds ?? this.seenStoryDate,
      viewersModels: viewersModels ?? this.viewersModels,
      localFilePath: localFilePath ?? this.localFilePath,
    );
  }

  bool get haslocalFilePath =>
      localFilePath != null && localFilePath!.isNotEmpty;

  bool get hasNotLocalFilePath =>
      localFilePath == null || localFilePath!.isEmpty;
}
