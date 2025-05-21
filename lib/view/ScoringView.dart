import 'package:cricket_commentary/controller/ChatGPTServiceController.dart';
import 'package:cricket_commentary/controller/ScoreController.dart';
import 'package:cricket_commentary/view/CricketRunMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../model/OperatorCommandsBoxDataModel.dart';
import '../utils/AppConstantData.dart';

class Scoringview extends StatelessWidget {
  Scoringview({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/scoreBackground.jpg',
                  ), // or NetworkImage
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "0/0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                "0/2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: BatsmanInfoComponent()),
                      Expanded(child: BatsmanInfoComponent()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xff2f3e48),
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sports_baseball,
                        color: CupertinoColors.systemGrey6,
                      ),
                      SizedBox(width: 8),
                      Text("Dev", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Text("0-0-0-0", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: GridWithFourthColumn(),
            ),
          ],
        ),
      ),
    );
  }
}

class BatsmanInfoComponent extends StatelessWidget {
  const BatsmanInfoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.sports_cricket, color: Colors.orange),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Akash cricsters", style: TextStyle(color: Colors.white)),
              Text(
                "0/(0)",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GridWithFourthColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGrey5,
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          // INNER BOX
          StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 4,
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 4,
              children: [
                ...AppConstantData.operatorCommandsBoxDataForCenterPanel.map((item) => StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: _TileBox(operatorCommandsBoxDataModel: item),
                )).toList(),
              ],
            ),
          ),

          ...AppConstantData.operatorCommandsBoxDataForSidePanel.map((item) => StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: _TileBox(operatorCommandsBoxDataModel: item),
          )).toList(),
        ],
      ),
    );
  }
}

class _TileBox extends StatelessWidget {
  final OperatorCommandsBoxDataModel operatorCommandsBoxDataModel;

  _TileBox({
    required this.operatorCommandsBoxDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        String commandTypeString = AppConstantData.getCommandTypeString(operatorCommandsBoxDataModel.commandType);
        ChatGPTServiceController chatgptController = ChatGPTServiceController();
        ScoreController scoreController = Get.put(ScoreController());
        scoreController.isEventReapeat = scoreController.commandTypeString.value == commandTypeString;
        scoreController.commandTypeString.value = commandTypeString;
        scoreController.commandType = operatorCommandsBoxDataModel.commandType;

        Get.to(CricketRunMap());
      },
      child: Container(
        color: operatorCommandsBoxDataModel.backgroundColor,
        child: Center(
          child: Text(operatorCommandsBoxDataModel.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: operatorCommandsBoxDataModel.titleColor), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}











