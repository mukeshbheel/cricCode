import 'package:cricket_commentary/controller/LiveStreamController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

class Livestreamingview extends StatefulWidget {
  @override
  _LivestreamingviewState createState() => _LivestreamingviewState();
}

class _LivestreamingviewState extends State<Livestreamingview> {
  late VlcPlayerController _vlcPlayerController;
  LiveStreamController liveStreamController = Get.put(LiveStreamController());

  @override
  void initState() {
    super.initState();

    _vlcPlayerController = VlcPlayerController.network(
      'rtmp://192.168.0.28/live/stream',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([VlcAdvancedOptions.networkCaching(300)]),
// Enables more detailed logs
      ),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.stop();
    _vlcPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RTMP Stream Player')),
      body: Obx(()=>Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                VlcPlayer(
                  controller: _vlcPlayerController,
                  aspectRatio: 16 / 9,
                  placeholder: Center(child: CircularProgressIndicator()),
                ),

                if (liveStreamController.showLivePopup.value)
                  Container(
                    color: Colors.black.withOpacity(
                      0.3,
                    ), // optional dark overlay for contrast
                    child: Image.asset(
                      liveStreamController.getImage(), // your gif file placed under assets/
                      fit: BoxFit.contain,
                    ),
                  )
              ],
            ),
          ),
        ],
      )),
    );
  }
}