import 'package:flutter/material.dart';
import 'package:u_tube_video_downloader/models/api_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: urlTextController,
              decoration: InputDecoration(
                hintText: "Enter your url",
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              YouTubeToMp3Service().getStatus(urlTextController.text);
            },
            label: Text("submit"),
            icon: Icon(Icons.navigate_next_rounded),
          )
        ],
      ),
    );
  }
}
