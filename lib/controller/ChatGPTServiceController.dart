import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatGPTServiceController {

  // Private named constructor
  ChatGPTServiceController._internal();

  // Static private instance
  static final ChatGPTServiceController _instance = ChatGPTServiceController._internal();

  // Public factory constructor
  factory ChatGPTServiceController() => _instance;

  final String _apiKey = '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'; // Replace with your Groq API Key

  final  messages = <Map<String, dynamic>>[];
  String systemMessage = "";

  // String promptString = commandTypeString + event;

  Future<String> generateCommentary(String event, Languages language, {bool isSameEventType = false}) async {
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    // Creating the system message based on the language

    systemMessage = 'You are a cricket commentator. Use neutral language, avoid gender-specific terms, and provide commentary in {language_name} with less than 300 charactors with general without any specific details. Do not mention anything about the fielders, umpire, bowlers and other ground person';

    switch (language) {
      case Languages.hindi:
        systemMessage = systemMessage.replaceAll("{language_name}", "Hindi");
        break;
      case Languages.bhojpuri:
        systemMessage = systemMessage.replaceAll("{language_name}", "Bhojpuri");
        break;
      default:
        systemMessage = systemMessage.replaceAll("{language_name}", "English");
    }

    debugPrint(systemMessage);

    // String promptString = commandTypeString + event;



    if(isSameEventType){
      messages.add({"role": "user", "content": event},);
    }else {
      messages.clear();
      messages.addAll([
        {"role": "system", "content": systemMessage},
        {"role": "user", "content": event},
      ]);
    }

    debugPrint(messages.toString());

    final data = {
      "model": "llama-3.3-70b-versatile", // Groq's available model
      "messages":messages,
      // "messages": [
      //   {"role": "system", "content": systemMessage},
      //   {"role": "user", "content": event},
      //   // {"role": "user", "content": event},
      //   // {"role": "user", "content": event}
      // ],
      "max_tokens": 100,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['choices'][0]['message']['content'];
    } else {
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load commentary');
    }
  }
}

enum Languages {
    hindi, bhojpuri, english
}
