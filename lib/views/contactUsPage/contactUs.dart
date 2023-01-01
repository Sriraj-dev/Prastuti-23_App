import 'package:flutter/material.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: ListView(
          children: [
          ],
        ),
      ),
    );
  }

  Widget convenerWidget(
      {required double height,
      required String name,
      required String position,
      required String phone}) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 5,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme().backgroundColor
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(ImagePaths.temp_pic),
                  radius: 45,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: AppTheme().headText1.copyWith(
                        color: AppTheme().primaryColor,
                        fontSize: 20,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  position,
                  style: AppTheme().headText2.copyWith(
                        color: AppTheme().secondaryColor,
                        fontSize: 16,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      phone,
                      style: AppTheme().headText2.copyWith(
                            color: AppTheme().secondaryColor,
                            fontSize: 16,
                      ),
                    ),
                    Icon(Icons.call,color: AppTheme().primaryColor,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
