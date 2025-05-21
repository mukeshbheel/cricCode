import 'package:cricket_commentary/controller/ScoreController.dart';
import 'package:cricket_commentary/model/ShotListWithAreaModel.dart';
import 'package:cricket_commentary/view/ScoringView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectShotView extends StatefulWidget {
  final ShotListWithAreaModel shotData;

  const SelectShotView({super.key, required this.shotData});

  @override
  State<SelectShotView> createState() => _SelectShotViewState();
}

class _SelectShotViewState extends State<SelectShotView> {
  String? selectedShot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Shot - ${widget.shotData.shotArea}')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: widget.shotData.availableShots.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  final shot = widget.shotData.availableShots[index];
                  final isSelected = shot == selectedShot;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedShot = shot;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.blueAccent : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        shot,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: selectedShot == null ? null : () {
              final ScoreController controller = Get.put(ScoreController());
              controller.shotType.value = selectedShot!;
              Get.offAll(() => Scoringview());
              controller.showCommentary();
            },
            child: Container(
              width: Get.size.width,
              height: 80,
              color: selectedShot == null ? Colors.grey : Colors.green,
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
