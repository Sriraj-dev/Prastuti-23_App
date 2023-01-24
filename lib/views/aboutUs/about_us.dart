

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/aboutUs/about_us_content.dart';

import '../../config/image_paths.dart';
import '../../utils/utils.dart';

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
          const DecorationImage(
              opacity: 1,
              image: AssetImage(ImagePaths.bgImage_dark),
              fit: BoxFit.cover
          )
              :const DecorationImage(
              opacity: 0.6,
              image: AssetImage(ImagePaths.bgImage_light),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: SizeConfig.height*0.89,
          width: SizeConfig.width*0.95,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Container(
                  height: SizeConfig.height*0.1632,
                  width: SizeConfig.height*0.12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: selectedAppTheme.isDarkMode?
                        const AssetImage(ImagePaths.bulb_dark):const AssetImage(ImagePaths.bulb_light),
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sponsors(
                        ImagePaths.gfg,
                        'GEEKS for GEEKS',
                      'https://www.geeksforgeeks.org/'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    sponsors(
                        ImagePaths.skillreactor,
                        'SKILLREACTOR',
                        'https://www.skillreactor.io/'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    sponsors(
                        ImagePaths.techanalogy,
                        'TEACH ANALOGY',
                        'https://techanalogy.org/'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    sponsors(
                        ImagePaths.elm,
                        'ELEARNMARKETS',
                        'https://www.elearnmarkets.com/'
                    )
                  ],
                ),
              ),
              const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    about_us_icons(
                        ImagePaths.instagram_squared,
                      about_us_links[0]
                    ),
                    about_us_icons(
                        ImagePaths.gmail_squared,
                        about_us_links[1]
                    ),
                    about_us_icons(
                        ImagePaths.linkedin_squared,
                        about_us_links[2]
                    ),
                    about_us_icons(
                        ImagePaths.prastuti_logo_squared,
                        about_us_links[3]
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget sponsors (
      String logo,
      String name,
      String url
      ) {
    return InkWell(
      onTap: ()async{
        Utils.launchLink(url, context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.height*0.075,
            width: SizeConfig.height*0.075,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(logo),
                    fit: BoxFit.cover
                ),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
          Text(
            name,
            style: AppTheme().headText1.copyWith(
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: selectedAppTheme.isDarkMode?
              Colors.white:AppTheme().primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget about_us_icons (
      String image,
      String url,
      ) {
    return InkWell(
      onTap: ()async{
        Utils.launchLink(url, context);
      },
      child: Container(
        height: SizeConfig.height*0.05,
        width: SizeConfig.height*0.05,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}