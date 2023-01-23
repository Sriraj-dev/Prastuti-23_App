



import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';


class NotificationServices{
  Future<String> getPlayerId() async {
    String playerId = "";
    await OneSignal.shared.setAppId(Env.one_signal_app_id);
    await OneSignal.shared.getDeviceState().then((value) {
      //print("The playerId is ${value!.userId}");
      playerId = value!.userId!;
    });

    return playerId;
  }
}