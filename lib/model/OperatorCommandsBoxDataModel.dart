import 'package:flutter/material.dart';

import '../utils/AppConstantData.dart';
import '../view/ScoringView.dart';

class OperatorCommandsBoxDataModel {
  final String title;
  Color titleColor = Colors.grey;
  Color backgroundColor = Colors.white;
  CommandType commandType;

  OperatorCommandsBoxDataModel({
    required this.title,
    this.titleColor = Colors.grey,
    this.backgroundColor = Colors.white,
    required this.commandType
  });
}