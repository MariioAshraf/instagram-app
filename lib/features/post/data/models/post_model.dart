import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userName;
  String uId;
  String? userProfileImage;
  String? postFileUrl;
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

  factory PostModel.fromJson(json) {
    return PostModel(
      postId: json['postId'],
      userName: json['name'],
      uId: json['uId'],
      userProfileImage: json['userProfileImage'],
      postFileUrl: json['postImage'] ?? '',
      postTitle: json['postTitle'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate().toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'name': userName,
      'uId': uId,
      'userProfileImage': userProfileImage,
      'postImage': postFileUrl,
      'postTitle': postTitle,
      'createdAt': createdAt,
    };
  }
}
