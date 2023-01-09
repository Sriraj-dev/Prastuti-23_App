
//TODO: Dark and Light Color Themes from Design Team.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme{

  //Color primaryColor = const Color.fromARGB(255, 0, 76, 125);
  Color primaryColor = const Color(0xFF004C7D);
  Color secondaryColor = const Color(0xFF4B7CB2);
  Color backgroundColor = const Color(0xFFDBF2FF);
  Color kSecondaryColor = const Color(0xFFDEA01E);

  Color kRedLight = Color(0xFFEDF4FE);
  Color kRed = Color(0xFFFBE4E6);
  Color kReddark = Color(0xFFF08A8E);
  
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