import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:instagram_app/features/post/data/repos/post_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../post_mock.mocks.dart';
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PostRepoImpl postRepoImpl;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    postRepoImpl = PostRepoImpl(
        // firestore: mockFirestore
    );
  });

  group('createPost', () {
    test('should return void on successful post creation', () async {
      final userModel = UserModel(
        uId: 'testUserId',
        name: 'Test User',
        profileImageUrl: 'testUrl',
      );

      final result = await postRepoImpl.createPost(
        userModel: userModel,
        postTitle: 'Test Title',
      );

      expect(result, const Right(null));
      verify(mockFirestore.collection('posts')).called(1);
    });
  });
}
