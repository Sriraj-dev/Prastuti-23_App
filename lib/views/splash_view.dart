import 'package:flutter/material.dart';
import 'package:prastuti_23/config/screen_config.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void didChangeDependencies() {
    SizeConfig.init(context);
  }


  //TODO: Complete the UI of Splash Screen
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child: Text("This is Splash Screen")
      ),

    );
  }
}
