

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/aboutUs/about_us_content.dart';

import '../../config/image_paths.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: selectedAppTheme.isDarkMode?
      Brightness.light:Brightness.dark,
    ));

    return Container(
      decoration: BoxDecoration(
          image: selectedAppTheme.isDarkMode?
          DecorationImage(
              opacity: 1,
              image: AssetImage(ImagePaths.bgImage_dark),
              fit: BoxFit.cover
          )
              :DecorationImage(
              opacity: 0.6,
              image: AssetImage(ImagePaths.bgImage_light),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.symmetric(vertical: 10),
          height: SizeConfig.height*0.89,
          width: SizeConfig.width*0.95,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: Container(
                  height: SizeConfig.height*0.1632,
                  width: SizeConfig.height*0.12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: selectedAppTheme.isDarkMode?
                        AssetImage(ImagePaths.bulb_dark):AssetImage(ImagePaths.bulb_light),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              ),
              Center(
                child: AutoSizeText(
                  'ABOUT US',
                  style: GoogleFonts.notoSerif(
                    color: selectedAppTheme.isDarkMode?
                    Colors.white:AppTheme().primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 50,
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                about_us,
                style: AppTheme().headText1.copyWith(
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: selectedAppTheme.isDarkMode?
                  Colors.white:AppTheme().primaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: AutoSizeText(
                    'SPONSORS',
                    style: GoogleFonts.notoSerif(
                      color: selectedAppTheme.isDarkMode?
                      Colors.white:AppTheme().primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                    )
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                  'REACH US ON',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                    color: selectedAppTheme.isDarkMode?
                    Colors.white:AppTheme().primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  )
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    about_us_icons(ImagePaths.instagram_squared),
                    about_us_icons(ImagePaths.gmail_squared),
                    about_us_icons(ImagePaths.linkedin_squared),
                    about_us_icons(ImagePaths.prastuti_logo_squared)
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget about_us_icons (String image) {
    return Container(
      height: SizeConfig.height*0.05,
      width: SizeConfig.height*0.05,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover
          )
      ),
    );
  }
}