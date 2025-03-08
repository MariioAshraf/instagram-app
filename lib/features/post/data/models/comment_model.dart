import '../../../../constants.dart';

class CommentModel {
  final String commentId;
  final String userId;
  final String comment;
  final DateTime createdAt;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.comment,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json[kCommentId],
      userId: json[kUserId],
      comment: json[kComment],
      createdAt: json[kCreatedAt].toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        kCommentId: commentId,
        kUserId: userId,
        kComment: comment,
        kCreatedAt: createdAt,
      };
}
