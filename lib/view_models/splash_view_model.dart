
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/repositories/splash_repository.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel{


  initiateApp(BuildContext context)async{

    checkNotificationPermission();

    //await Future.delayed(const Duration(seconds: 3));
    checkUserSession(context);
  }

  checkUserSession(BuildContext context)async{
    String? userId = await SecureStorage().getToken();
    if(userId == null){
      Navigator.of(context).popAndPushNamed(RouteNames.loginView);
    }else{
      bool isLoggedIn = await SplashRepository().loginUsingUserId(userId);
      if(isLoggedIn){
        AuthViewModelNotifier().navigateToRequiredScreen(context);
        //Navigator.of(context).popAndPushNamed(RouteNames.loginView);
        // Utils.flushBarMessage(
        //   message: "LoggedIn",
        //   context: context,
        //   bgColor: Colors.purple
        // );
      }else{
        Navigator.of(context).popAndPushNamed(RouteNames.loginView);
      }
    }
  }

  checkNotificationPermission()async{
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(Env.one_signal_app_id);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });
  }

}