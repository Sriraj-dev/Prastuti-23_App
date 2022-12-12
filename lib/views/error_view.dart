
import 'package:flutter/material.dart';


class ErrorView extends StatefulWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {


  //TODO: UI of Error Screen
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("This is a Error Screen!!"),
      ),
    );
  }
}
