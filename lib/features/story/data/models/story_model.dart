import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../../auth/models/user_model.dart';

part 'story_model.g.dart';

@HiveType(typeId: 0)
enum MediaType {
  @HiveField(0)
  image,
  @HiveField(1)
  video,
}

@HiveType(typeId: 1)
class StoryModel {
  @HiveField(0)
  String? fileUrl;
  @HiveField(1)
  final String caption;
  @HiveField(2)
  final MediaType mediaType;
  @HiveField(3)
  final int duration;
  @HiveField(4)
  final String userId;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  String? localFilePath;
  @HiveField(7)
  final String storyId;
  @HiveField(8)
  Map<String, String>? seenStoryDate;
  @HiveField(9)
  Map<String, UserModel>? viewersModels;
  @HiveField(10)
  UserModel? storyUserModel;

  StoryModel({
    this.fileUrl,
    required this.caption,
    required this.mediaType,
    required this.duration,
    required this.userId,
    required this.createdAt,
    this.localFilePath,
    this.viewersModels,
    this.seenStoryDate,
    required this.storyId,
    this.storyUserModel,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      fileUrl: json['fileUrl'],
      caption: json['caption'],
      mediaType: MediaType.values.firstWhere(
        (e) => e.toString() == json['mediaType'],
        orElse: () => MediaType.image,
      ),
      duration: json['duration'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      storyId: json['storyId'],
      localFilePath: json['localFilePath'],
      storyUserModel: UserModel.fromJson(json['storyUserModel']),
    );
  }

  @override
  String toString() {
    return '''
  StoryModel(
    fileUrl: $fileUrl,
    caption: $caption,
    mediaType: $mediaType,
    duration: $duration,
    userId: $userId,
    createdAt: $createdAt,
    localFilePath: $localFilePath,
    storyId: $storyId,
  )
  ''';
  }

  Map<String, dynamic> toJson() {
    return {
      'fileUrl': fileUrl,
      'caption': caption,
      'mediaType': mediaType.toString(),
      'duration': duration,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'storyId': storyId,
      'localFilePath': localFilePath,
      'storyUserModel': storyUserModel?.toJson()
    };
  }
}
