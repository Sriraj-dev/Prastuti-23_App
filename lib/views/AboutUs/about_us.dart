

import 'package:flutter/material.dart';
import 'package:prastuti_23/config/color_palette.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,

      body: Center(
        child: Text("About Us Page!!!"),
      ),
    );
  }
}