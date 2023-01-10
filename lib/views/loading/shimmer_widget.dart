import 'package:flutter/material.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:shimmer/shimmer.dart';

Widget skeleton(double height, double width) {
  return SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
        child: Container(
          width: SizeConfig.widthPercent * 25,
          height: 35,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
        baseColor: Colors.grey.withOpacity(0.04),
        highlightColor: selectedAppTheme.isDarkMode?
        AppTheme().backgroundColor_Dark:AppTheme().backgroundColor
    ),
  );
}
