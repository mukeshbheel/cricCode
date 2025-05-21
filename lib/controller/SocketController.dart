import 'package:cricket_commentary/controller/LiveStreamController.dart';
import 'package:cricket_commentary/utils/ApiUrlConstants.dart';
import 'package:cricket_commentary/utils/AppConstantData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController {
  // Singleton setup
  SocketController._internal();
  static final _instance = SocketController._internal();
  factory SocketController() => _instance;
  final LiveStreamController liveStreamController = Get.put(LiveStreamController());

  late IO.Socket socket; // Declare socket as instance variable

  void connectToSocket() {
    print("connectToSocket called");

    socket = IO.io(
      ApiUrlConstants.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('🔌 Socket connected');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff2f3e48),
          content: Text("Connected to socket", style: TextStyle(fontSize: 16, color: Colors.white),),
          duration: Duration(seconds: 7),
        ),
      );
    });

    socket.on(
      'liveStreamingPopupData',
      (data) {
        print("liveStreamingPopupData called : ${data}");

        liveStreamController.setLiveStreaminPopupType(data);
      },
    );

    socket.onDisconnect((_) => print('❌ Socket disconnected'));
  }

  void sendCommandToLiveServer(String commadRuns) {
    socket.emit('sendCommandToLive', commadRuns);
  }

  void disconnect() {
    socket.disconnect();
  }


}
