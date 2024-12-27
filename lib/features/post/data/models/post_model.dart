import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userName;
  String uId;
  String? userProfileImage;
  List<String>? postFileUrl;
  String? postTitle;
  DateTime createdAt;
  String postId;

  PostModel({
    required this.postId,
    required this.userName,
    required this.uId,
    this.userProfileImage,
    this.postFileUrl,
    this.postTitle,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userName: json['name'],
      uId: json['uId'],
      userProfileImage: json['userProfileImage'],
      // Ensure postFileUrl is a List<String>
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
      'uId': uId,
      'userProfileImage': userProfileImage,
      'postFileUrls': postFileUrl,
      'postTitle': postTitle,
      'createdAt': createdAt,
    };
  }
}
