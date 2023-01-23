import 'dart:async';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/views/contactUsPage/contact_us_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {

  late PageController _eventController;
  late PageController _teamController;
  late Timer _timerTeam;
  late Timer _timerEvent;
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
    _timerTeam.cancel();
    _timerEvent.cancel();
    super.dispose();
  }

  _startTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    _timerTeam = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (_teamController.page! >= 5) {
        _teamController.jumpTo(0);

      } else {
        _teamController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    });
    _timerEvent = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (_eventController.page! >= 2) {
        _eventController.jumpTo(0);
      } else {
        _eventController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    });
  }

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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.width*0.95,
                height: SizeConfig.height*0.28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        contactWidget(
                          convenor_images[1],
                          convenor_names[1],
                          'Co-Convenor',
                          convenor_phone[1],
                          convenor_linkedIn[1],
                          SizeConfig.width*0.28,
                        ),
                      ],
                    ),
                    contactWidget(
                      convenor_images[0],
                      convenor_names[0],
                      'Convenor',
                      convenor_phone[0],
                      convenor_linkedIn[0],
                      SizeConfig.width*0.28,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        contactWidget(
                          convenor_images[2],
                          convenor_names[2],
                          'Co-Convenor',
                          convenor_phone[2],
                          convenor_linkedIn[2],
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Center(
                      child: AutoSizeText(
                          'TEAM LEADS',
                          style: GoogleFonts.comicNeue(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: selectedAppTheme.isDarkMode?
                              Colors.white:AppTheme().primaryColor
                          )
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        child: Transform.rotate(
                          angle: math.pi/2,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentTeam,
                            count: (team_name.length + 1) ~/ 2,
                            effect: WormEffect(
                              activeDotColor: AppTheme().kSecondaryColor,
                              dotHeight: 4.5.sp,
                              dotWidth: 4.5.sp,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onHorizontalDragCancel: () {
                          _timerTeam.cancel();
                        },
                        child: Container(
                          height: SizeConfig.height*0.26,
                          width: SizeConfig.width*0.8,
                          child: PageView.builder(
                            controller: _teamController,
                            itemCount: (team_name.length+1)~/2,
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
                                    padding: const EdgeInsets.symmetric(horizontal: 17),
                                    child: contactWidget(
                                      team_leads_images[2*index],
                                      team_leads_names[2*index],
                                      team_name[2*index],
                                      team_leads_phone[2*index],
                                      team_leads_linkedIn[2*index],
                                      SizeConfig.width*0.30,
                                    ),
                                  ):Container(),

                                  (2*index+1 < team_name.length)?Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 17),
                                    child: contactWidget(
                                      team_leads_images[2*index+1],
                                      team_leads_names[2*index+1],
                                      team_name[2*index+1],
                                      team_leads_phone[2 * index+1],
                                      team_leads_linkedIn[2 * index+1],
                                      SizeConfig.width*0.30,
                                    ),
                                  ):const SizedBox(width: 0,),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        child: Transform.rotate(
                          angle: math.pi/2,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentTeam,
                            count: (team_name.length + 1) ~/ 2,
                            effect: WormEffect(
                              activeDotColor: Colors.transparent,
                              dotColor: Colors.transparent,
                              dotHeight: 6.0.sp,
                              dotWidth: 6.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Center(
                      child: AutoSizeText('EVENT HEADS',
                          style: GoogleFonts.comicNeue(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: selectedAppTheme.isDarkMode?
                              Colors.white:AppTheme().primaryColor
                          )
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: math.pi/2,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentEvent,
                            count: (event_name.length + 1) ~/ 2,
                            effect: WormEffect(
                              activeDotColor: AppTheme().kSecondaryColor,
                              dotHeight: 4.5.sp,
                              dotWidth: 4.5.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onHorizontalDragCancel: () {
                            _timerEvent.cancel();
                          },
                          child: Container(
                            height: SizeConfig.height*0.26,
                            width: SizeConfig.width*0.8,
                            child: PageView.builder(
                              controller: _eventController,
                              itemCount: (event_name.length+1)~/2,
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
                                      padding: const EdgeInsets.symmetric(horizontal: 17),
                                      child: contactWidget(
                                        event_head_images[2*index],
                                        event_heads_names[2*index],
                                        event_name[2*index],
                                        event_heads_phone[2*index],
                                        event_heads_linkedIn[2*index],
                                        SizeConfig.width*0.30,
                                      ),
                                    ):const SizedBox(width: 0),

                                    (2*index+1 < event_name.length)?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 17),
                                      child: contactWidget(
                                        event_head_images[2*index+1],
                                        event_heads_names[2*index+1],
                                        event_name[2*index+1],
                                        event_heads_phone[2 * index+1],
                                        event_heads_linkedIn[2 * index+1],
                                        SizeConfig.width*0.30,
                                      ),
                                    ):const SizedBox(width: 0),

                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: math.pi/2,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentEvent,
                            count: (event_name.length + 1) ~/ 2,
                            effect: WormEffect(
                              activeDotColor: Colors.transparent,
                              dotColor: Colors.transparent,
                              dotHeight: 4.5.sp,
                              dotWidth: 4.5.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                        offset: const Offset(4, 4)
                    )]
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: AutoSizeText(
                          name,
                          style: AppTheme().headText1.copyWith(
                              color: selectedAppTheme.isDarkMode?
                              Colors.white:AppTheme().primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      FittedBox(
                        child: AutoSizeText(
                          position,
                          style: AppTheme().headText2.copyWith(
                            color: selectedAppTheme.isDarkMode?
                            Colors.white:AppTheme().primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/contact_us/contact.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()async{
                              Utils.launchLink(linkedin, context);
                            },
                            child: Container(
                              height: SizeConfig.height*0.035,
                              width: SizeConfig.height*0.035,
                              decoration: const BoxDecoration(
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
                        offset: const Offset(0, 4)
                    )]
                ),
              )
          ),
        ],
      ),
    );
  }
}
