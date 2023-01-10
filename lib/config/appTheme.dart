
//TODO: Dark and Light Color Themes from Design Team.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme{

  //Light Theme
  Color primaryColor = const Color(0xFF004C7D);
  Color secondaryColor = const Color(0xFF4B7CB2);
  Color backgroundColor = const Color(0xFFDBF2FF);
  Color kSecondaryColor = const Color(0xFFDEA01E);
  Color secondaryColorLight = const Color(0xFFB5C8E8);
  Color primaryColorDark = const Color(0xFF153F5E);
  Color primaryColorExtraDark = const Color(0xFF112C3D);
  Color primaryColorLight = const Color(0xFF11669D);
  Color kRedLight = const Color(0xFFEDF4FE);
  Color kRed = const Color(0xFFFBE4E6);
  Color kReddark = const Color(0xFFF08A8E);

  //Dark Theme
  Color primaryColor_Dark = const Color(0xFF00121A);
  Color secondaryColor_Dark = const Color(0xFF18272F);
  Color backgroundColor_Dark = const Color(0xFF1B1B1B);
  Color kSecondaryColor_Dark = const Color(0xFF7A5A00);
  Color secondaryColorLight_Dark = const Color(0xFF3B3B3B);
  Color primaryColorExtraDark_Dark = const Color(0xFF010505);
  Color primaryColorExtra_Dark = const Color(0xFF3B3B3B);
  Color primaryColorLight_Dark = const Color(0xFF1C2C38);
  Color primaryColorDark_Dark = const Color(0xFF0B1D2A);
  Color kRedLight_Dark = const Color(0xFF082E42);
  Color kRed_Dark = const Color(0xFF4B4B4B);
  Color kReddark_Dark = const Color(0xFF3F0A0A);
  Color accentColor = const Color(0xFFD9FF00);
  
  //Added TextStyles by Yash

final headText1 =   GoogleFonts.comicNeue(
  color: Colors.white,
  decoration: TextDecoration
      .none,

  fontSize: 40,
);
final headText2 =  GoogleFonts.catamaran(
  color: Colors.white,
  decoration: TextDecoration
      .none,

  fontSize: 16,
);
}

class TextColour{

  Color white = Colors.white;

}

class BtnColor {

  Color submitBtn = Colors.deepOrange;
  Color regBtn = Colors.blue;
  Color googleLogin = Colors.black;

}

class selectedAppTheme {
  static bool isDarkMode = true;
}