import 'package:covid_tracker_app/view/countries.dart';
import 'package:covid_tracker_app/view/world_stats.dart';
import 'package:flutter/material.dart';
import 'view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home:const SplashScreen(),
    );
  }
}