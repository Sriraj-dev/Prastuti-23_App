
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/repositories/splash_repository.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

class SplashViewModel{


  initiateApp(BuildContext context)async{

    checkNotificationPermission();

    //await Future.delayed(const Duration(seconds: 3));
    //_checkVersion(context);
    checkUserSession(context);
  }

  // void _checkVersion(context) async {
  //   final newVersion = NewVersion(
  //     androidId: "com.prastuti.prastuti_23",
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status!,
  //     dialogTitle: "Update Available 🎊",
  //     dismissButtonText: "Close",
  //     dialogText: "PLease update the app from" +
  //         "${status.localVersion}" +
  //         "to" +
  //         "${status.storeVersion}",
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "Update 🤞",
  //   );
  // }

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