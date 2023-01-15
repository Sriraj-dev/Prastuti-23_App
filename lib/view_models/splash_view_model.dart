
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';

class SplashViewModel{


  initiateApp(BuildContext context)async{
    //TODO: Check User Session using SharedPreferences - Sriraj

    checkNotificationPermission();

    await Future.delayed(const Duration(seconds: 4));

    
    Navigator.of(context).popAndPushNamed(RouteNames.loginView);
    // isLoggedIn.isLogged?Navigator.of(context).popAndPushNamed(RouteNames.loginView)
    //     :Navigator.of(context).popAndPushNamed(RouteNames.homeView);
  }

  checkNotificationPermission()async{
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(Env.one_signal_app_id);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
    });
  }

}