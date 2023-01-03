



import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../config/one_signal.dart';

class NotificationServices{
  Future<void> getPlayerId() async {
    await OneSignal.shared.setAppId(One_signal().app_id);
    await OneSignal.shared.getDeviceState().then((value) {
      print("The playerId is ${value!.userId}");
      return value;
    });

    
  }
}