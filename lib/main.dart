import 'package:ez_english/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Supabase.initialize(
    url: 'https://txtkdxqiihbhcqrhippj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4dGtkeHFpaWhiaGNxcmhpcHBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA4NTY0MjUsImV4cCI6MjAyNjQzMjQyNX0.dnWbHZVBjvOhtG9pCWg9q_b2egoTpaAm0jGyQN-_WZw',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
