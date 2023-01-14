
import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';

import '../config/appTheme.dart';


class ErrorView extends StatefulWidget {
  String error;
  ErrorView({Key? key, this.error=''}) : super(key: key);


  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {


  //TODO: UI of Error Screen - Manash/Yash
  @override
  Widget build(BuildContext context) {
    return  NetworkGiffDialog(
      image: Image.asset('assets/error.gif'),
      title: Text(
          'ERROR !!',
          style: AppTheme().headText1.copyWith(
            color: Colors.black,
              fontWeight: FontWeight.bold
          )
      ),
      description: Text(
        "You vented outside the horizon. Let's get back in !!",
        style: AppTheme().headText2.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
      onlyOkButton: true,
      buttonOkColor: AppTheme().backgroundColor,
      buttonOkText: Text(
        "GET IN",
        style: AppTheme().headText2.copyWith(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      onOkButtonPressed: () {
        Navigator.pushReplacementNamed(context, RouteNames.homeView);
      },
      cornerRadius: 10.0,
      buttonRadius: 5.0,
      entryAnimation: EntryAnimation.bottomRight,
    );
  }
}
