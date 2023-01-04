import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/views/contactUsPage/contact_us_content.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {

  late PageController _eventController;
  late PageController _teamController;
  late Timer _timer;
  int _currentEvent = 0;
  int _currentTeam = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventController = PageController(initialPage: 0);
    _teamController = PageController(initialPage: 0);
    _startTimer();
  }

  @override
  void dispose() {
    _eventController.dispose();
    _teamController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _startTimer() async {
    await Future.delayed(Duration(seconds: 1));
    _timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (_eventController.page! >= 2) {
        _eventController.jumpTo(0);
      } else {
        _eventController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
      if (_teamController.page! >= 5) {
        _teamController.jumpTo(0);
      } else {
        _teamController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.width*0.95,
              height: SizeConfig.height*0.28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      contactWidget(
                        convenor_images[1],
                        convenor_names[1],
                        'Co-Convenor',
                        convenor_phone[1],
                        "LinkedIn",
                        SizeConfig.width*0.28,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      contactWidget(
                        convenor_images[0],
                        convenor_names[0],
                        'Convenor',
                        convenor_phone[0],
                        "LinkedIn",
                        SizeConfig.width*0.28,
                      ),
                      SizedBox(
                        height: 23,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      contactWidget(
                        convenor_images[2],
                        convenor_names[2],
                        convenor_phone[2],
                        "LinkedIn",
                        'Co-Convenor',
                        SizeConfig.width*0.28,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: AutoSizeText(
                      'TEAM LEADS',
                      style: GoogleFonts.comicNeue(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme().primaryColor
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: SizeConfig.height*0.25,
                  width: SizeConfig.width*0.9,
                  child: PageView.builder(
                    controller: _teamController,
                    itemCount: ((team_name.length+1)/2).toInt(),
                    onPageChanged: (int team) {
                      setState(() {
                        _currentTeam = team;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return (_currentTeam != index)?Container()
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (2*index < team_name.length)?Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: contactWidget(
                              team_leads_images[2*index],
                              team_leads_names[2*index],
                              team_name[2*index],
                              team_leads_phone[2*index],
                              "LinkedIn",
                              SizeConfig.width*0.30,
                            ),
                          ):Container(),

                          (2*index+1 < team_name.length)?Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: contactWidget(
                              team_leads_images[2*index+1],
                              team_leads_names[2*index+1],
                              team_name[2*index+1],
                              team_leads_phone[2 * index],
                              "LinkedIn",
                              SizeConfig.width*0.30,
                            ),
                          ):SizedBox(width: 0,),
                        ],
                      );
                    },
                  ),
                ),
              
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: AutoSizeText(
                    'EVENT HEADS',
                    style: GoogleFonts.comicNeue(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme().primaryColor
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: SizeConfig.height*0.25,
                  width: SizeConfig.width*0.9,
                  child: PageView.builder(
                    controller: _eventController,
                    itemCount: ((event_name.length+1)/2).toInt(),
                    onPageChanged: (int event) {
                      setState(() {
                        _currentEvent = event;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return (_currentEvent != index)?Container()
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (2*index < event_name.length)?Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: contactWidget(
                              event_head_images[2*index],
                              event_heads_names[2*index],
                              event_name[2*index],
                              event_heads_phone[2*index],
                              "",
                              SizeConfig.width*0.30,
                            ),
                          ):Container(),

                          (2*index+1 < event_name.length)?Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: contactWidget(
                              event_head_images[2*index+1],
                              event_heads_names[2*index+1],
                              event_name[2*index+1],
                              event_heads_phone[2 * index+1],
                              "",
                              SizeConfig.width*0.30,
                            ),
                          ):SizedBox(width: 0,),
                        ],
                      );
                    },
                  ),
                ),
                ],
            ),
          ],
        ),
      ),
    );
  }

  Widget contactWidget(
      String profile_image,
      String name,
      String position,
      String phone,
      String linkedin,
      double width,
      ) {
    return Container(
      height: SizeConfig.height*0.25,
      width: width,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 60,
              left: 0,
              child: Container(
                height: SizeConfig.height*0.16,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme().backgroundColor,
                    boxShadow: [BoxShadow(
                        color: AppTheme().primaryColor.withOpacity(0.3),
                        blurRadius: 4.0,
                        spreadRadius: 3.0,
                        offset: Offset(4, 4)
                    )]
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        name,
                        style: AppTheme().headText1.copyWith(
                            color: AppTheme().primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      AutoSizeText(
                        position,
                        style: AppTheme().headText2.copyWith(
                          color: AppTheme().primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              final call = Uri.parse('tel:+91 $phone');
                              if (await canLaunchUrl(call)) {
                                launchUrl(call);
                              } else {
                                Utils.flushBarMessage(
                                  message: "Could not Call $phone",
                                  context: context,
                                  bgColor: Colors.redAccent
                                );
                              }
                            },
                            child: Container(
                              height: SizeConfig.height*0.03,
                              width: SizeConfig.height*0.03,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/contact_us/contact.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: ()async{
                              final web = Uri.parse(
                                'https://www.linkedin.com/in/sriraj-palakurthi-ab86061bb/',
                              );
                              if (await canLaunchUrl(web)) {
                                launchUrl(web);
                              } else {
                                Utils.flushBarMessage(
                                    message: "Could not Launch LinkedIn currently!",
                                    context: context,
                                    bgColor: Colors.redAccent);
                              }
                            },
                            child: Container(
                              height: SizeConfig.height*0.035,
                              width: SizeConfig.height*0.035,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/contact_us/linkedin.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
          ),
          Positioned(
              top: 0,

              child: Container(
                height: SizeConfig.height*0.1,
                width: SizeConfig.height*0.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(profile_image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [BoxShadow(
                        color: AppTheme().secondaryColor.withOpacity(0.5),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 4)
                    )]
                ),
              )
          ),
        ],
      ),
    );
  }
}
