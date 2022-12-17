
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/events_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/eventsPage/events.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> with SingleTickerProviderStateMixin{

  final _selectedEvent = 0.obs;
  EventsViewAnimation eventsViewAnimation = EventsViewAnimation();
  late final animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = Get.put(eventsViewAnimation);
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
        // backgroundColor: AppTheme().backgroundColor,
        backgroundColor: Colors.purple,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 20,left: 0,right: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Opacity(
                        opacity: animationController.pagePaddingValue.value,
                        child: Padding(
                          padding: EdgeInsets.only(left: (1 - animationController
                                          .pagePaddingValue.value) * 30),
                          child: Text(
                            titles[_selectedEvent.value],
                            style: TextStyle(
                                fontSize: 45,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ) ,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Opacity(
                        opacity: animationController.pagePaddingValue.value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: (1 -
                                      animationController
                                          .pagePaddingValue.value) *
                                  30),
                          child: Text(
                            desc[_selectedEvent.value],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightPercent * 25,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: titles.length,
                    onPageChanged: ((value) {
                      _selectedEvent.value = value;
                      eventsViewAnimation.restartPageAnimation();
                    }),
                    itemBuilder: (context, index) {
                      return event_tab(index);
                    }),
                )
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "settings"),
          ],
        ),
      ),
    );
  }

  Widget event_tab(int index){
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: SizeConfig.heightPercent * 25,
        width: SizeConfig.width - 20,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(event_images[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 18),
              height: SizeConfig.heightPercent*10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card_Text(titles[index], 35, 10, 0),
                  Card_Text('Schedule', 20, 20, 0)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   padding: EdgeInsets.only(right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Card_Button('Submit', BtnColor().submitBtn),
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(right: 25, bottom: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card_Button('Register', BtnColor().regBtn)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      elevation: 10.0,
      color: Colors.transparent,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      shadowColor: Colors.purple.shade900,
    );
  }

}

Widget Card_Text (String text, double size, double left, double top) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.fromLTRB(left, top, 0, 0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: TextColour().white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    ],
  );
}

Widget Card_Button (String text, Color color) {
  return ElevatedButton(
    onPressed: () {
      // TODO: Submission Link
    },
    child: Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: TextColour().white,
        letterSpacing: 1,
      ),
    ),
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      backgroundColor: Color.fromARGB(255, 4, 106, 150),
      fixedSize: Size(130, 40),
      shadowColor: Color.fromARGB(255, 0, 76, 125),
      elevation: 15,
    ),
  );
}
