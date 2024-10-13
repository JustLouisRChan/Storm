import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/video_provider.dart'; // Adjust the path as needed
import 'pages/feed.dart'; // Adjust the path as needed

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideoProvider()),
        // You can add more providers here in the future
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedPage(), // Ensure FeedPage is the home
      debugShowCheckedModeBanner: false,
    );
  }
}
