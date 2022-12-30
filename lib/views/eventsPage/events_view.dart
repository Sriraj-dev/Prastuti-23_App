import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/events_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/eventsPage/events_view_content.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 00,top: 0,left: 0,right: 0),
          child: Column(
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
                                          .pagePaddingValue.value) * 30),
                          child: AutoSizeText(
                            titles[_selectedEvent.value],
                            style: AppTheme().headText1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ) ,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () => Opacity(
                          opacity: animationController.pagePaddingValue.value,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: (1 -
                                        animationController
                                            .pagePaddingValue.value) *
                                    30),
                            child: SizedBox(
                              width: double.infinity,
                              height: SizeConfig.height*0.485,
                              child: ListView(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      desc[_selectedEvent.value],
                                      style: AppTheme().headText2.copyWith(
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'TIMELINE',
                                    style: AppTheme().headText2.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1
                                    ),
                                  ),
                                  TimeLineFirst(
                                    'Started',
                                    'Bla Bla Bla Bla',
                                    'ended',
                                    '12/12/22',
                                    '17 : 00'
                                  ),
                                  TimeLine(
                                      'Workshop 1',
                                      'Bla Bla Bla Bla',
                                      'ended',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLine(
                                      'Workshop 2',
                                      'Bla Bla Bla Bla',
                                      'ended',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLine(
                                      'Workshop 3',
                                      'Bla Bla Bla Bla',
                                      'onGoing',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLine('Problem Statement',
                                      'Bla Bla Bla Bla',
                                      'coming',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLine('Submission',
                                      'Bla Bla Bla Bla',
                                      'coming',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLine('Result',
                                      'Bla Bla Bla Bla',
                                      'coming',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                  TimeLineLast('Prize',
                                      'Bla Bla Bla Bla',
                                      'coming',
                                      '12/12/22',
                                      '17 : 00'
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: AutoSizeText(
                          'Register',
                          style: AppTheme().headText2.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: AppTheme().primaryColor,
                          shadowColor: AppTheme().primaryColor.withOpacity(0.5),
                          elevation: 10,
                          fixedSize: Size(140, 40),
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
                      }),
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

  Widget TimeLineFirst(String event, String detail, String status, String date, String time) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 2,
                height: 30,
                color: Colors.transparent,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Utils.statusImage(status)),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 212, 228, 255),
              boxShadow: [BoxShadow(
                  color: AppTheme().primaryColor.withOpacity(0.2),
                  blurRadius: 7.0,
                  spreadRadius: 3.0,
                  offset: Offset(7, 7)
              )]
            ),
            height: SizeConfig.height*0.07,
            width: SizeConfig.width*0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeLineEvent(event),
                    TimeLineDetail(detail)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/profile_view/calendar.png'),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(date)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/events_view/clock.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(time)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget TimeLine(String event, String detail, String status, String date, String time) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Utils.statusImage(status)),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 212, 228, 255),
                boxShadow: [BoxShadow(
                    color: AppTheme().primaryColor.withOpacity(0.2),
                    blurRadius: 7.0,
                    spreadRadius: 3.0,
                    offset: Offset(7, 7)
                )]
            ),
            height: SizeConfig.height*0.07,
            width: SizeConfig.width*0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeLineEvent(event),
                    TimeLineDetail(detail)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/profile_view/calendar.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(date),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/events_view/clock.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(time)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget TimeLineLast(String event, String detail, String status, String date, String time) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 2,
                height: 30,
                color: Colors.black,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Utils.statusImage(status)),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: Colors.transparent,
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 212, 228, 255),
                boxShadow: [BoxShadow(
                    color: AppTheme().primaryColor.withOpacity(0.2),
                    blurRadius: 7.0,
                    spreadRadius: 3.0,
                    offset: Offset(7, 7)
                )]
            ),
            height: SizeConfig.height*0.07,
            width: SizeConfig.width*0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeLineEvent(event),
                    TimeLineDetail(detail)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/profile_view/calendar.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(date),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.height*0.015,
                          width: SizeConfig.height*0.015,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/events_view/clock.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TimeLineSchedule(time),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget TimeLineEvent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget TimeLineDetail(String text) {
    return AutoSizeText(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          fontFamily: 'Roboto'
      ),
    );
  }

  Widget TimeLineSchedule(String sch){
    return AutoSizeText(
      sch,
      style: TextStyle(
          fontSize: 12
      ),
    );
  }
 
}
