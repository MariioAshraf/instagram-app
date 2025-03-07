// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:instagram_app/core/functions/hive_functions.dart';
// import '../../../../constants.dart';
// import '../models/post_model.dart';
//
// abstract class PostsRemoteDataSource {
//   Future<List<PostModel>> fetchPosts({required int limit});
// }
//
// class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
//   final _postsCollection =
//       FirebaseFirestore.instance.collection(kPostsCollection);
//   DocumentSnapshot? _lastDocument;
//
//   @override
//   Future<List<PostModel>> fetchPosts({required int limit}) async {
//     Query query =
//         _postsCollection.orderBy(kCreatedAt, descending: true).limit(limit);
//
//     if (_lastDocument != null) {
//       query = query.startAfterDocument(_lastDocument!);
//     }
//     final querySnapshot = await query.get();
//     if (querySnapshot.docs.isNotEmpty) {
//       _lastDocument = querySnapshot.docs.last; // update last document
//     }
//     List<PostModel> posts = querySnapshot.docs
//         .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
//         .toList();
//     if (posts.isNotEmpty) HiveFunctions.savePosts(posts);
//     return posts;
//   }
// }
