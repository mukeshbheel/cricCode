library cricket_run_map;

import 'dart:math';
import 'package:cricket_commentary/controller/ScoreController.dart';
import 'package:cricket_commentary/model/ShotListWithAreaModel.dart';
import 'package:cricket_commentary/utils/AppConstantData.dart';
import 'package:cricket_commentary/view/SelectShotView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/RunMapPainter.dart';

class CricketRunMap extends StatefulWidget {
  final double width = 350;
  final double height = 350;
  bool isRightHand;
  // final void Function(String) onPositionSelected;

  CricketRunMap({
    super.key,
    // required this.width,
    // required this.height,
    this.isRightHand = true,
    // required this.onPositionSelected,
  });

  @override
  State<CricketRunMap> createState() => _CricketRunMapState();
}

class _CricketRunMapState extends State<CricketRunMap> {

  final scoreController = Get.put(ScoreController());

  final List<String> rightHandPositionNames = [
    'Deep Mid\nWicket',
    'Long On',
    'Long Off',
    'Deep Cover',
    'Deep Point',
    'Third Man',
    'Deep\nFine Leg',
    'Deep\nSquare Leg',
  ];

  final List<String> leftHandPositionNames = [
    'Deep Cover',
    'Long Off',
    'Long On',
    'Deep Mid\nWicket',
    'Deep\nSquare Leg',
    'Deep\nFine Leg',
    'Third Man',
    'Deep Point',
  ];

  Offset? tapPoint;
  int? selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Shot Area", style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                setState(() {
                  tapPoint = details.localPosition;
                  if (tapPoint != null) {
                    final dx = tapPoint!.dx - (widget.width / 2);
                    final dy = tapPoint!.dy - (widget.height / 2);
                    final angle = atan2(dy, dx);
                    const sliceAngle = 2 * pi / 8;
                    double normalizedAngle = angle < 0 ? (2 * pi + angle) : angle;
                    normalizedAngle = (normalizedAngle + (4 * pi / 2)) % (2 * pi);
                    selectedPosition = (normalizedAngle / sliceAngle).floor();
                    String selectedPositionString = "";

                    // Call the callback with the selected position name
                    if (widget.isRightHand == true) {
                      selectedPositionString = rightHandPositionNames[selectedPosition!]
                          .replaceAll("\n", " ");
                    } else {
                      selectedPositionString = leftHandPositionNames[selectedPosition!]
                          .replaceAll("\n", " ");
                    }

                    //update score area
                    scoreController.shotArea.value = selectedPositionString;
                    ShotListWithAreaModel? item = AppConstantData.getSingleShotListWithAreaModel(selectedPositionString);
                    if(item != null) {
                      Get.to(SelectShotView(shotData: item));
                    }
                  }
                });
              },
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF669801),
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFFFF9800),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(widget.width, widget.height),
                        painter: RunMapPainter(
                            widget.isRightHand
                                ? rightHandPositionNames
                                : leftHandPositionNames,
                            tapPoint: tapPoint,
                            selectedPosition: selectedPosition),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Transform.translate(
                                offset: const Offset(0, -10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: widget.isRightHand
                                      ? const Text("OFF",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))
                                      : const Text("LEG",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                              height: widget.height * 0.2,
                              color: Colors.amberAccent,
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: widget.isRightHand
                                      ? Image.asset(
                                      "assets/ic_wagon_striker.png",
                                      color: Colors.black,
                                      fit: BoxFit.cover)
                                      : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(pi),
                                      child: Image.asset(
                                          "assets/ic_wagon_striker.png",
                                          color: Colors.black,
                                          fit: BoxFit.cover))),
                            ),
                            Expanded(
                              child: Transform.translate(
                                offset: const Offset(0, -10),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: widget.isRightHand
                                      ? const Text("LEG",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))
                                      : const Text("OFF",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}