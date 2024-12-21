import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async{
  await dotenv.load();
  await supabaseInitialization();
  runApp(const MyApp());
}

Future<void> supabaseInitialization() async {
  String url = dotenv.env['PROJECT_URL'] ?? '';
  String anonKey = dotenv.env['API_KEY'] ?? '';
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
    );
  }
}

