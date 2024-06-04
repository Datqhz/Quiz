import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/auth_provider.dart';
import 'package:quiz/screens/wrapper.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(29, 161, 242, 1))),
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
      home: const Wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
