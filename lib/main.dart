import 'package:flutter/material.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/screens/home_screen.dart';
import 'package:movieflix/services/api_service.dart';

void main() {
  // ApiService().getPopularMovies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: HomeScreen(), // DetailScreen(),
    );
  }
}
