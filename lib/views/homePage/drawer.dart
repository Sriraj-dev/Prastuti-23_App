
import 'package:flutter/material.dart';
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
      width: SizeConfig.widthPercent * 65,
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
                  Row(
                    children: [
                      Image.asset(
                        ImagePaths.prastuti_logo,
                        scale: 1.5,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prastuti' 23",
                              style: AppTheme().headText2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme().secondaryColor
                              ),
                            ),
                            Text(
                              "Annual Departmental fest",
                              overflow: TextOverflow.fade,
                              style: AppTheme().headText2.copyWith(
                                  fontSize: 13,
                                  color: Colors.black,
                                  overflow: TextOverflow.fade
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: ()=>homeViewController.changeSelectedView(0),
                    title: Text("Events"),
                    leading: Icon(
                      Icons.event_note_rounded,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: () =>homeViewController.changeSelectedView(1),
                    title: Text("Profile"),
                    leading: Icon(
                      Icons.person,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: ()=>homeViewController.changeSelectedView(2),
                    title: Text("About us"),
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme().secondaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text("Contact us"),
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
