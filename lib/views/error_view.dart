
import 'package:flutter/material.dart';


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
    return  Scaffold(
      body: Center(
        child: Text(widget.error.toString(),
        ),
      ),
    );
  }
}
