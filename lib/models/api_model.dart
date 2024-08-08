import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YouTubeToMp3Service {
  final String _baseUrl = 'https://youtube-to-mp315.p.rapidapi.com';
  final String _apiKey = '9621e3954amsh283d94076b12d61p129b7bjsn98fdb423a782';

  Future<Map<String, dynamic>> getStatus(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/status/$id'),
      headers: {
        'X-RapidAPI-Host': 'youtube-to-mp315.p.rapidapi.com',
        'X-RapidAPI-Key': _apiKey,
      },
    );

    // Print the status code
    print('Status response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get status');
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlTextController = TextEditingController();
  String statusMessage = '';

  String _extractVideoId(String url) {
    final uri = Uri.parse(url);
    if (uri.host == 'youtu.be') {
      // Handle shortened YouTube URL
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
    } else {
      // Handle standard YouTube URL
      final queryParams = uri.queryParameters;
      return queryParams['v'] ?? '';
    }
  }

  Future<void> _checkStatus() async {
    final videoId = _extractVideoId(urlTextController.text);
    if (videoId.isEmpty) {
      setState(() {
        statusMessage = 'Invalid URL or missing video ID';
      });
      return;
    }

    try {
      final response = await YouTubeToMp3Service().getStatus(videoId);
      setState(() {
        statusMessage =
            'Status: ${response['status']}'; // Adjust based on actual response structure
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Status Checker'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: urlTextController,
              decoration: InputDecoration(
                hintText: "Enter your YouTube URL",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _checkStatus,
            label: Text("Submit"),
            icon: Icon(Icons.navigate_next_rounded),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(statusMessage),
          ),
        ],
      ),
    );
  }
}
