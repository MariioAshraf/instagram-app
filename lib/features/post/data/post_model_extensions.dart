import 'package:instagram_app/features/post/data/models/post_model.dart';

extension PostModelExtensions on PostModel {
  PostModel copyWith({
    String? userName,
    String? uId,
    List<String>? postFileUrl,
    String? postTitle,
    DateTime? createdAt,
    String? postId,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
  }) {
    return PostModel(
      isLiked: isLiked ?? this.isLiked,
      userName: userName ?? this.userName,
      uId: uId ?? this.uId,
      postFileUrl: postFileUrl ?? this.postFileUrl,
      postTitle: postTitle ?? this.postTitle,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }
}
