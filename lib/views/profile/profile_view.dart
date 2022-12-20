import 'package:flutter/material.dart';
import 'package:prastuti_23/config/color_palette.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      body: Center(
        child: Text("This is the Profile Page"),
      ),
    );
  }
}