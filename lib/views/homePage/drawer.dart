
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/home_view_model.dart';


//TODO: Beautify This Widget if possible:

Widget drawer() {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: SizeConfig.heightPercent * 50,
      width: SizeConfig.widthPercent * 62,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme().backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightPercent * 40,
              child: ListView(
                children: [
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Image.asset(
                        ImagePaths.prastuti_logo,
                        scale: 1.2,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Prastuti' 23",
                        style: AppTheme().headText2.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppTheme().secondaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: ()=>homeViewController.changeSelectedView(0),
                    title: Text("Events",
                    style: AppTheme().headText2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),),
                    leading: Icon(
                      Icons.event_note_rounded,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: () =>homeViewController.changeSelectedView(1),
                    title: Text("Profile",
                        style: AppTheme().headText2.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    leading: Icon(
                      Icons.person,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: ()=>homeViewController.changeSelectedView(2),
                    title: Text("About us",
                        style: AppTheme().headText2.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: () => homeViewController.changeSelectedView(3),
                    title: Text("Contact us",
                        style: AppTheme().headText2.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                    leading: Icon(
                      Icons.phone,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.heightPercent * 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppTheme().primaryColor),
              child: Center(
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
