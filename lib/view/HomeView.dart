import 'package:cricket_commentary/controller/SocketController.dart';
import 'package:cricket_commentary/view/LiveStreamingView.dart';
import 'package:cricket_commentary/view/ScoringView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homeview extends StatefulWidget {
  Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  SocketController socketController = SocketController();

  @override
  void initState() {
    // TODO: implement initState
    try {
      socketController.connectToSocket();
    }catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(Scoringview());
              },
              child: const Text('Go to Scoring Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(Livestreamingview());
              },
              child: const Text('Go to Live stream'),
            ),
          ],
        ),
      ),
    );
  }
}
