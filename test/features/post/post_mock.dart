import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:instagram_app/features/post/domain/repos/post_repo.dart';

@GenerateMocks([
  FirebaseFirestore,
  SupabaseClient,
  PostRepo,
  CollectionReference<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
])
void main() {}
