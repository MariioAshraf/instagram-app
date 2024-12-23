import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> supabaseInitialization() async {
  await Supabase.initialize(
    url: 'https://vnvtsgunrfjhyxwtaejk.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZudnRzZ3VucmZqaHl4d3RhZWprIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MTM3OTgsImV4cCI6MjA1MDE4OTc5OH0.jnbBAWy_JTpBBjobmXZkiw43oD-JwKdBqsVCLVF1yU4',
  );
}
