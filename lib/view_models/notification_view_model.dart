



import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';


class NotificationServices{
  Future<void> getPlayerId() async {
    await OneSignal.shared.setAppId(Env.one_signal_app_id);
    await OneSignal.shared.getDeviceState().then((value) {
      print("The playerId is ${value!.userId}");
      return value;
    });
  }
}