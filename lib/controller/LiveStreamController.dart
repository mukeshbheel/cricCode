import 'package:cricket_commentary/utils/Constants.dart';
import 'package:get/get.dart';

class LiveStreamController extends GetxController {

  LiveStreamPopupType? liveStreamPopupType;
  RxBool showLivePopup = false.obs;

  void setLiveStreaminPopupType(String popupTypeString) {
    switch (popupTypeString) {
      case "4" :
        liveStreamPopupType = LiveStreamPopupType.four;
        showPopup(true);
      case "6" :
        liveStreamPopupType = LiveStreamPopupType.six;
        showPopup(true);
      case "out" :
        liveStreamPopupType = LiveStreamPopupType.out;
        showPopup(true);
      default :
        liveStreamPopupType = null;
    }
  }

  String getImage() {
    switch (liveStreamPopupType) {
      case LiveStreamPopupType.four:
        return Constants.gif_four;
      case LiveStreamPopupType.six:
        return Constants.gif_six;
      case LiveStreamPopupType.out:
        return Constants.gif_out;
      default:
        return Constants.gif_four;
    }
    return 'assets/no_result.gif';
  }

  void showPopup(bool value){
    print("showPopup called");
    showLivePopup.value = value;
    update();
    Future.delayed(Duration(seconds: 5), () {
      showLivePopup.value = false;
      update();
    });
  }

}




enum LiveStreamPopupType {
  out, four, six
}