import 'package:flutter/material.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/Provider/notes_provide.dart';
// import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/signup_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          // useMaterial3: true,
        ),
        home: const SignupPage(),
      ),
    );
  }
}
