import 'package:flutter/material.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/splash_view_model.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashViewModel splashViewModel = SplashViewModel();

  @override
  void didChangeDependencies() {
    SizeConfig.init(context);
  }

  @override
  void initState() {
    //Comment This line .. if u wanna stay in the splash screen..
    splashViewModel.initiateApp(context);
  }


  //TODO: Complete the UI of Splash Screen - Manash/Yash
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child: Text("This is Splash Screen")
      ),

    );
  }
}
