import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:note_app/loding_screen.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/login_page.dart';
// import 'package:note_app/pages/home_page.dart';
// import 'package:note_app/pages/signup_page.dart';
import 'package:note_app/services/api_service.dart';
import 'package:note_app/widget/widget.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NotesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isToken = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ApiService.getUser(context);
    fatchData();
  }

  Future<void> fatchData() async {
    setState(() {
      isLoading = false;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isLoading = true;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isToken = Provider.of<AuthProvider>(context).user.token!.isNotEmpty;

    // if (isToken && isLoading) {
    //   // Set isLoading to false once the widget is built
    //   Future.delayed(const Duration(seconds: 2), () {
    //     setState(() {
    //       isLoading = true;
    //     });
    //   });
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // useMaterial3: true,
      ),
      home: isLoading
          ? isToken
              ? const HomePage()
              : const LoginPage()
          : const LodingScreen(),
    );
  }
}
