import 'package:cricket_commentary/controller/ChatGPTServiceController.dart';
import 'package:cricket_commentary/controller/SocketController.dart';
import 'package:cricket_commentary/utils/AppConstantData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreController extends GetxController {
  RxString commandTypeStringForSocket = "".obs;
  RxString commandTypeString = "".obs;
  CommandType? commandType;
  RxString shotArea = "".obs;
  RxString shotType = "".obs;
  bool isEventReapeat = false;

  final ChatGPTServiceController chatGPTServiceController = ChatGPTServiceController();

  String getEventString() {
    return "${commandTypeString.value} ${shotArea.value} ${shotType.value}";
  }

  void showCommentary() async{
    String commentaryString = await chatGPTServiceController.generateCommentary(getEventString(), Languages.english, isSameEventType: isEventReapeat);

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff2f3e48),
        content: Text(commentaryString, style: TextStyle(fontSize: 16, color: Colors.white),),
        duration: Duration(seconds: 7),
      ),
    );

    if(commandType != null){
      final socketController = SocketController();
      switch(commandType) {
        case CommandType.four :
          socketController.sendCommandToLiveServer("4");
        case CommandType.six :
          socketController.sendCommandToLiveServer("6");
        case CommandType.out :
          socketController.sendCommandToLiveServer("out");
        default:
          print('default');
      }
    }
  }
}
