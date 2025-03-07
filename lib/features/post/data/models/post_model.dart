import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userName;
  String uId;
  List<String>? postFileUrl;
  String? postTitle;
  DateTime createdAt;
  String postId;
  bool isLiked;

  int likesCount;
  int commentsCount;

  PostModel({
    required this.postId,
    required this.userName,
    required this.uId,
    this.isLiked = false,
    this.postFileUrl,
    this.postTitle,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userName: json['name'],
      isLiked: json['isLiked'],
      uId: json['uId'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      postFileUrl: (json['postFileUrls'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      postTitle: json['postTitle'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate().toLocal(),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'name': userName,
      'likesCount': likesCount,
      'isLiked': isLiked,
      'commentsCount': commentsCount,
      'uId': uId,
      'postFileUrls': postFileUrl,
      'postTitle': postTitle,
      'createdAt': createdAt,
    };
  }
}
