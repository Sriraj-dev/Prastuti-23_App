import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/events_view_animation.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/eventsPage/event_timeline.dart';
import 'package:prastuti_23/views/eventsPage/events_view_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utils/utils.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> with SingleTickerProviderStateMixin{

  final _selectedEvent = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init State is running in EventsView ---------");
    eventsViewAnimation.initiatePageAnimation(this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Container(
      color: AppTheme().backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme().backgroundColor,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: AppTheme().backgroundColor.withOpacity(opacityAnimation.value),
              leading: Center(
                child: InkWell(
                  onTap: _onDrawerTapped,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    color: AppTheme().secondaryColor,
                    size: 33,
                    progress: drawerAnimationController.view,
                  ),
                ),
              ),
              actions: [
                Obx((() => 
                  AnimatedSmoothIndicator(
                  activeIndex: _selectedEvent.value,
                  count: titles.length,
                  effect: WormEffect(
                    activeDotColor: AppTheme().kSecondaryColor,
                    dotHeight: 6.0.sp,
                    dotWidth: 6.0.sp,
                  ),
                )
                )),
                SizedBox(width: 15,),
              ],
            ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Opacity(
                        opacity: animationController.pagePaddingValue.value,
                        child: Padding(
                          padding: EdgeInsets.only(left: (1 - animationController
                                          .pagePaddingValue.value) * 0),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  titles[_selectedEvent.value],
                                  style: AppTheme().headText1.copyWith(
                                      color: AppTheme().primaryColor,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: AutoSizeText(
                                    'Register',
                                    style: AppTheme().headText2.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    backgroundColor: AppTheme().kSecondaryColor,
                                    shadowColor: AppTheme()
                                        .kSecondaryColor
                                        .withOpacity(0.5),
                                    elevation: 5,
                                    fixedSize: Size(140, 40),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) ,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Obx(
                        () => Opacity(
                          opacity: animationController.pagePaddingValue.value,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: (1 -
                                        animationController
                                            .pagePaddingValue.value) *
                                    25),
                            child: SizedBox(
                              width: double.infinity,
                              height: SizeConfig.height*0.52,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      desc[_selectedEvent.value],
                                      style: AppTheme().headText2.copyWith(
                                          color: AppTheme().secondaryColor
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.people_alt_rounded,
                                          color: AppTheme().kSecondaryColor,),
                                          SizedBox(width: 5,),
                                          Text("103",
                                          style: AppTheme().headText2.copyWith(
                                            color: AppTheme().secondaryColor
                                          ),
                                        )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.sports_gymnastics_outlined,
                                          color: AppTheme().kSecondaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Solo Event",
                                          style: AppTheme().headText2.copyWith(
                                              color: AppTheme().secondaryColor),
                                        )
                                      ],
                                    ),
                                  ],
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent,
                                    ),
                                    child: ExpansionTile(
                                      title: Text(
                                        "Timeline",
                                        style: AppTheme().headText2.copyWith(
                                          color: AppTheme().primaryColor,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                  
                                      children: [
                                        Event_Timeline(timeline: timeLines[_selectedEvent.value]),
                                      ],
                                    ),
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent
                                    ),
                                    child: ExpansionTile(
                                    title: Text(
                                      "Rules",
                                      style: AppTheme()
                                          .headText2
                                          .copyWith(
                                            color: AppTheme().primaryColor,
                                            fontWeight: FontWeight.w500
                                          ),
                                    ),
                                    children: const [
                                      Text(
                                          "Rules for this event will be announced soon!!")
                                    ],
                                  ),
                                ),
                                Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        title: Text(
                                          "Rewards",
                                          style: AppTheme()
                                              .headText2
                                              .copyWith(color: AppTheme().primaryColor,
                                              fontWeight: FontWeight.w500
                                            ),
                                        ),
                                        children: const [
                                          Text(
                                              "Rewards for this event will be announced soon!!")
                                        ],
                                      ),
                                    )
                                  
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: SizeConfig.heightPercent * 25,
                  child: PageView.builder(
                      controller: PageController(viewportFraction: 0.88),
                      itemCount: titles.length,
                      onPageChanged: ((value) {
                        _selectedEvent.value = value;
                        eventsViewAnimation.restartPageAnimation();
                      }),
                      itemBuilder: (context, index) {
                        return eventImage(index);
                      }
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget eventImage(int index){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 30,top: 10),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(left: 20),
          height: SizeConfig.heightPercent * 25,
          width: SizeConfig.width - 20,
          //margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            //TODO: decide shadow color .
            boxShadow: [
              BoxShadow(
                color: AppTheme().secondaryColor.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            image: DecorationImage(
                image: AssetImage(event_images[index]),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  void _onDrawerTapped() {
    if (drawerAnimationController.isCompleted) {
      drawerAnimationController.reverse();
    } else {
      drawerAnimationController.forward();
    }
  }
  
}
