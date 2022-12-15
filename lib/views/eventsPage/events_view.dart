
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
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,

      body: Padding(
        padding: const EdgeInsets.only(bottom: 20,top: 100,left: 0,right: 0),
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
                              fontSize: 55,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ) ,
                  ),
                  SizedBox(
                    height: 15,
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
                      return event_image(index);
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
    );
  }

  Widget event_image(int index){
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: SizeConfig.heightPercent * 25,
      width: SizeConfig.width - 20,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: AssetImage(event_images[index]),
            fit: BoxFit.cover),
      ),
    );
  }

}