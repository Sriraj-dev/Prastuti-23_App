

import 'package:flutter/cupertino.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';

class SplashViewModel{


  initiateApp(BuildContext context)async{
    //TODO: Check User Session using SharedPreferences - Sriraj

    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(RouteNames.loginView);
  }

}