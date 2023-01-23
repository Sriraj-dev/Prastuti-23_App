
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';

class SplashViewModel{


  initiateApp(BuildContext context)async{

    checkNotificationPermission();

    await Future.delayed(const Duration(seconds: 3));

    
    Navigator.of(context).popAndPushNamed(RouteNames.loginView);
  }

  checkNotificationPermission()async{
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(Env.one_signal_app_id);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });
  }

}