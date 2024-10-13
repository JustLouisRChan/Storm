// video_provider.dart
import 'package:flutter/material.dart';
import 'video.dart'; // Adjust this import based on your structure
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class VideoProvider with ChangeNotifier {
  ApiResponse? _videoData;

  ApiResponse? get videoData => _videoData;

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> jsonData = json.decode(response);
    _videoData = ApiResponse.fromJson(jsonData);
    notifyListeners(); // Notify listeners of state changes
  }
}
