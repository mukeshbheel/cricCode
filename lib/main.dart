import 'package:cricket_commentary/controller/ChatGPTServiceController.dart';
import 'package:cricket_commentary/view/CricketRunMap.dart';
import 'package:cricket_commentary/view/HomeView.dart';
import 'package:cricket_commentary/view/ScoringView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Homeview(),
      //       home: CricketRunMap()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _commentary = "";

  final chatGPTServiceController = ChatGPTServiceController();

  void _fetchCommentary(
    String event,
    Languages language, {
    bool isSameEvent = false,
  }) async {
    String commentary = await chatGPTServiceController.generateCommentary(
      event,
      language,
      isSameEventType: isSameEvent,
    );
    setState(() {
      _commentary = commentary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(_commentary)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchCommentary("four run, cover drive, mid-off", Languages.english);
          _fetchCommentary(
            "four run, lofted shot, mid-on",
            Languages.english,
            isSameEvent: true,
          );
          _fetchCommentary("one run, lofted shot, mid-on", Languages.english);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
