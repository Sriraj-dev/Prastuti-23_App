
//TODO: Dark and Light Color Themes from Design Team.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppTheme{

  //Light Theme
  Color primaryColor = selectedAppTheme.isDarkMode?
  Color(0xFF00121A):Color(0xFF004C7D);
  Color secondaryColor = selectedAppTheme.isDarkMode?
  Color(0xFF18272F):Color(0xFF4B7CB2);
  Color backgroundColor = selectedAppTheme.isDarkMode?
  Color(0xFF343434):Color(0xFFDBF2FF);
  Color kSecondaryColor = Color(0xFFDEA01E);
  Color secondaryColorLight = selectedAppTheme.isDarkMode?
  Color(0xFF3B3B3B):Color(0xFFB5C8E8);
  Color primaryColorDark = selectedAppTheme.isDarkMode?
  const Color(0xFF0B1D2A):Color(0xFF153F5E);
  Color primaryColorExtraDark = selectedAppTheme.isDarkMode?
  Color(0xFF010505):Color(0xFF112C3D);
  Color primaryColorLight = selectedAppTheme.isDarkMode?
  Color(0xFF1C2C38):Color(0xFF11669D);
  Color kRedLight = selectedAppTheme.isDarkMode?
  Color(0xFF082E42):Color(0xFFEDF4FE);
  Color kRed = selectedAppTheme.isDarkMode?
  Color(0xFF4B4B4B):Color(0xFFFBE4E6);
  Color kReddark = selectedAppTheme.isDarkMode?
  Color(0xFF3F0A0A):Color(0xFFF08A8E);

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

  static final darkTheme = ThemeData(

  );

  static final lightTheme = ThemeData(

  );

}

class selectedAppTheme {

  static SharedPreferences? _preferences;

  static const _isDark = 'mode';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setMode(bool mode) async =>
    await _preferences?.setBool(_isDark, mode);
  static bool? getMode() => _preferences?.getBool(_isDark);

  static bool isDarkMode = false;

}