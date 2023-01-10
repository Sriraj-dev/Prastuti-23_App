import 'package:flutter/material.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/views/authentication/login_view.dart';
import 'package:prastuti_23/views/error_view.dart';
import 'package:prastuti_23/views/eventsPage/events_view.dart';
import 'package:prastuti_23/views/homePage/homeView.dart';
import 'package:prastuti_23/views/profile/profile_view.dart';
import 'package:prastuti_23/views/splash_view.dart';

import '../../views/aboutUs/about_us.dart';

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

      // Events View
      case RouteNames.eventsView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EventsView());

      
      //Home View
      case RouteNames.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RouteNames.profileView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileView());

        case RouteNames.aboutusView:
        return MaterialPageRoute(builder:
            (BuildContext context) => const  AboutUsView()
        );

      //Invalid Route Exception
      default:
        return MaterialPageRoute(builder:
            (BuildContext context)=>const ErrorView()
        );
    }
  }
}