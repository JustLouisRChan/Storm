import 'package:flutter/material.dart';

import 'package:flutter_app/pages/home.dart';
import 'package:provider/provider.dart';
import 'providers/video_provider.dart'; // Adjust import as necessary

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VideoProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}