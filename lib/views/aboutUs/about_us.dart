

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/color_palette.dart';
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
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,

      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -300,
            left: -300,
            child: Blob.animatedRandom(
              size:800,
              edgesCount:5,
              minGrowth:1,
              duration:  Duration(milliseconds:5000),
              loop: true,
              styles:  BlobStyles(
                color:  Colors.green,
                gradient:  LinearGradient(
                    colors: [AppTheme().kSecondaryColor.withOpacity(0.5),
                      AppTheme().kReddark])
                    .createShader(Rect.fromLTRB(0, 0, 300, 300)),
                strokeWidth:3,
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 50,
            child: Blob.animatedRandom(
              size:800,
              edgesCount:5,
              minGrowth:1,
              duration:  Duration(milliseconds:5000),
              loop: true,
              styles:  BlobStyles(
                color:  Colors.green,
                gradient:  LinearGradient(
                  colors: [AppTheme().kRed.withOpacity(0.5),
                  AppTheme().kSecondaryColor.withOpacity(0.5)])
                    .createShader(Rect.fromLTRB(0, 0, 10, 10)),
                strokeWidth:3,
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                height: SizeConfig.height*0.89,
                width: SizeConfig.width*0.95,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    AutoSizeText(
                        'ABOUT US',
                        style: GoogleFonts.notoSerif(
                          color: AppTheme().primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 60,
                        )
                    ),
                    AutoSizeText(
                      about_us,
                      style: AppTheme().headText1.copyWith(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: AppTheme().primaryColor
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                        'SPONSORS',
                        style: GoogleFonts.notoSerif(
                          color: AppTheme().primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                        )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                        'REACH US ON',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSerif(
                          color: AppTheme().primaryColor,
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
          )
        ],
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