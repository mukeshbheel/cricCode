import 'package:cricket_commentary/model/ShotListWithAreaModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/OperatorCommandsBoxDataModel.dart';

class AppConstantData {
  static Color grey_cececf = Color(0xffcececf);

  static final List
  operatorCommandsBoxDataForCenterPanel = <OperatorCommandsBoxDataModel>[
    OperatorCommandsBoxDataModel(title: "0", commandType: CommandType.zero),
    OperatorCommandsBoxDataModel(title: "1", commandType: CommandType.one),
    OperatorCommandsBoxDataModel(title: "2", commandType: CommandType.two),
    OperatorCommandsBoxDataModel(title: "3", commandType: CommandType.three),
    OperatorCommandsBoxDataModel(
      title: "4\nFOUR",
      commandType: CommandType.four,
    ),
    OperatorCommandsBoxDataModel(title: "6\nSIX", commandType: CommandType.six),
    OperatorCommandsBoxDataModel(
      title: "WD",
      backgroundColor: grey_cececf,
      commandType: CommandType.wide,
    ),
    OperatorCommandsBoxDataModel(
      title: "NB",
      backgroundColor: grey_cececf,
      commandType: CommandType.noBall,
    ),
    OperatorCommandsBoxDataModel(
      title: "BYE",
      backgroundColor: grey_cececf,
      commandType: CommandType.bye,
    ),
  ];

  static final List operatorCommandsBoxDataForSidePanel =
      <OperatorCommandsBoxDataModel>[
        OperatorCommandsBoxDataModel(
          title: "UNDO",
          backgroundColor: grey_cececf,
          titleColor: Colors.green,
          commandType: CommandType.undo,
        ),
        OperatorCommandsBoxDataModel(
          title: "5,7",
          backgroundColor: grey_cececf,
          commandType: CommandType.five,
        ),
        OperatorCommandsBoxDataModel(
          title: "OUT",
          backgroundColor: grey_cececf,
          titleColor: Colors.red,
          commandType: CommandType.out,
        ),
        OperatorCommandsBoxDataModel(
          title: "LB",
          backgroundColor: grey_cececf,
          commandType: CommandType.legBye,
        ),
      ];

  static String getCommandTypeString(CommandType commandType) {
    String commadString = "";
    switch (commandType) {
      case CommandType.zero:
        commadString = "dot ball";
      case CommandType.one:
        commadString = "One run";
      case CommandType.two:
        commadString = "two run";
      case CommandType.three:
        commadString = "three run";
      case CommandType.four:
        commadString = "four run";
      case CommandType.five:
        commadString = "five run";
      case CommandType.six:
        commadString = "six run";
      case CommandType.seven:
        commadString = "seven run";

      case CommandType.wide:
        commadString = "wide ball";
      case CommandType.noBall:
        commadString = "no ball";
      case CommandType.bye:
        commadString = "One run bye";
      case CommandType.legBye:
        commadString = "2 run legBye";
      case CommandType.out:
        commadString = "out";
      default:
        commadString = "";
    }

    return commadString;
  }

  static List<ShotListWithAreaModel> shotListByArea = [
    ShotListWithAreaModel(
      shotArea: 'Deep Cover',
      availableShots: [
        'Cover Drive',
        'Square Drive',
        'Inside-out Shot',
        'Lofted Cover Drive',
        'Reverse Sweep (lofted)',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Long Off',
      availableShots: [
        'Off Drive',
        'Straight Drive (angled)',
        'Inside-out Shot',
        'Lofted Off Drive',
        'Helicopter Shot (off-side)',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Long On',
      availableShots: [
        'On Drive',
        'Lofted On Drive',
        'Straight Drive (angled)',
        'Flick Shot',
        'Helicopter Shot',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Deep Mid Wicket',
      availableShots: [
        'Pull Shot',
        'Slog Shot',
        'Slog Sweep',
        'Flick Shot',
        'Hook Shot',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Deep Square Leg',
      availableShots: [
        'Pull Shot',
        'Hook Shot',
        'Sweep Shot',
        'Flick Shot',
        'Slog Sweep',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Deep Fine Leg',
      availableShots: [
        'Leg Glance',
        'Paddle Sweep',
        'Hook Shot',
        'Flick Shot',
        'Dilscoop',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Third Man',
      availableShots: [
        'Upper Cut',
        'Late Cut',
        'Glide',
        'Edge (intentional/unintentional)',
        'Ramp Shot',
      ],
    ),
    ShotListWithAreaModel(
      shotArea: 'Deep Point',
      availableShots: [
        'Cut Shot',
        'Square Cut',
        'Back Foot Punch',
        'Late Cut',
        'Reverse Sweep',
      ],
    ),
  ];

  static ShotListWithAreaModel? getSingleShotListWithAreaModel (String shotArea) {
     var index = shotListByArea.indexWhere((element) => element.shotArea == shotArea);
     if (index != -1) {
       return shotListByArea[index];
     }
     return null;
  }

}

enum CommandType {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  wide,
  noBall,
  bye,
  legBye,
  undo,
  out,
}
