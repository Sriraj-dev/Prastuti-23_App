import 'package:flutter/material.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/views/authentication/login_view.dart';
import 'package:prastuti_23/views/error_view.dart';
import 'package:prastuti_23/views/splash_view.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name){

      //SplashView
      case RouteNames.splashView:
        return MaterialPageRoute(builder:
            (BuildContext context) => const SplashView()
        );

      //ErrorView
      case RouteNames.errorView:
        return MaterialPageRoute(builder:
            (BuildContext context)=>const ErrorView()
        );

      //LoginView
      case RouteNames.loginView:
        return MaterialPageRoute(builder:
            (BuildContext context) => const LoginView()
        );

      //Invalid Route Exception
      default:
        return MaterialPageRoute(builder:
            (BuildContext context)=>const ErrorView()
        );
    }
  }
}