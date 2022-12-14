import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/events_view_animation.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/models/eventListModel.dart';
import 'package:prastuti_23/views/error_view.dart';
import 'package:prastuti_23/views/eventsPage/event_timeline.dart';
import 'package:prastuti_23/views/eventsPage/events_view_content.dart';
import 'package:prastuti_23/views/loading/events_view_loading.dart';
import 'package:prastuti_23/views/ui/show_model_team.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../config/image_paths.dart';
import '../../view_models/events_view_model.dart';
import '../profile/profile_view.dart';
import '../profile/profile_view_content.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView>
    with SingleTickerProviderStateMixin {
  final _selectedEvent = 0.obs;
  bool isRegistered = false;

  // ButtonState state = ButtonState.init;
  // bool isAnimating = true;
  // bool isPressed = false;

  @override
  void initState() {
    super.initState();
    eventsViewAnimation.initiatePageAnimation(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.bgImage),
          fit: BoxFit.cover
        )
      ),
      child: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final allEventsList = ref.watch(eventsProvider);
          return allEventsList.when(
              error: ((e, stackTrace) => ErrorView(error: e.toString(),)),
              loading: ()=>const Events_view_skeleton(),
              data: (allEvents){
                List<Events> events = allEvents.events as List<Events>;
                return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: buildAppBar(events),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Opacity(
                              opacity:
                                  animationController.pagePaddingValue.value,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: (1 -
                                            animationController
                                                .pagePaddingValue.value) *
                                        0),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (events[_selectedEvent.value].name ??
                                                "Invalid")
                                            .toUpperCase(),
                                        style: AppTheme().headText1.copyWith(
                                            color: selectedAppTheme.isDarkMode?
                                            Colors.white:AppTheme().primaryColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          isRegistered?''/// TODO Implement Automated Registration
                                          :showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(27))),
                                              builder: (context) =>
                                                  ShowModelTeams());
                                        },
                                        child: isRegistered? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(ImagePaths.WhatsApp),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            ),
                                            Text(
                                              'WhatsApp',
                                              style: AppTheme().headText2.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ):AutoSizeText(
                                          'Register',
                                          style: AppTheme().headText2.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: isRegistered?
                                          Colors.green:AppTheme().kSecondaryColor,
                                          shadowColor: isRegistered?
                                          Colors.greenAccent:AppTheme().kSecondaryColor.withOpacity(0.5),
                                          elevation: 5,
                                          fixedSize: Size(140, 40),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Obx(
                              () => Opacity(
                                opacity:
                                    animationController.pagePaddingValue.value,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: (1 -
                                              animationController
                                                  .pagePaddingValue.value) *
                                          25),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: SizeConfig.height * 0.52,
                                    child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              events[_selectedEvent.value]
                                                      .description ??
                                                  "",
                                              style: AppTheme()
                                                  .headText2
                                                  .copyWith(
                                                      color: selectedAppTheme.isDarkMode?
                                                      Colors.white:AppTheme().secondaryColor
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.people_alt_rounded,
                                                    color: AppTheme().kSecondaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    (events[_selectedEvent
                                                                    .value]
                                                                .noOfParticipants ??
                                                            0)
                                                        .toString(),
                                                    style: AppTheme()
                                                        .headText2
                                                        .copyWith(
                                                            color: selectedAppTheme.isDarkMode?
                                                            Colors.white:AppTheme().secondaryColor
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .sports_gymnastics_outlined,
                                                    color: AppTheme().kSecondaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    (events[_selectedEvent
                                                                .value]
                                                            .teamEvent!)
                                                        ? "Team Event"
                                                        : "Solo Event",
                                                    style: AppTheme()
                                                        .headText2
                                                        .copyWith(
                                                            color: selectedAppTheme.isDarkMode?
                                                            Colors.white:AppTheme().secondaryColor
                                                    ),
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
                                              iconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              collapsedIconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              title: Text(
                                                "Timeline",
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: selectedAppTheme.isDarkMode?
                                                        Colors.white:AppTheme().primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              children: [
                                                Event_Timeline(
                                                  timelines: events[
                                                          _selectedEvent.value]
                                                      .timeline!,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              iconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              collapsedIconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              title: Text(
                                                "Problem Statement",
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: selectedAppTheme.isDarkMode?
                                                        Colors.white:AppTheme().primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              children: [
                                                Text(
                                                  events[_selectedEvent.value]
                                                          .rules ??
                                                      "",
                                                  style: AppTheme().headText1.copyWith(
                                                      color: selectedAppTheme.isDarkMode?
                                                      Colors.white:Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              iconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              collapsedIconColor: selectedAppTheme.isDarkMode?
                                              Colors.white:Colors.black,
                                              title: Text(
                                                "Resouces",
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: selectedAppTheme.isDarkMode?
                                                        Colors.white:AppTheme().primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              children: [
                                                Text(
                                                    events[_selectedEvent.value]
                                                            .rewards ??
                                                        "",
                                                  style: AppTheme().headText1.copyWith(
                                                      color: selectedAppTheme.isDarkMode?
                                                      Colors.white:Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildPageView(events)
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Container buildPageView(List<Events> events) {
    return Container(
      height: SizeConfig.heightPercent * 25,
      child: PageView.builder(
          controller: PageController(viewportFraction: 0.88),
          itemCount: events.length,
          onPageChanged: ((value) {
            _selectedEvent.value = value;
            eventsViewAnimation.restartPageAnimation();
          }),
          itemBuilder: (context, index) {
            String image =
                event_images[(events[index].name ?? "Codigo").toUpperCase()]!;
            return eventImage(image);
          }),
    );
  }

  AppBar buildAppBar(List<Events> events) {
    return AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Center(
              child: InkWell(
                onTap: _onDrawerTapped,
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: selectedAppTheme.isDarkMode?
                  Colors.white:AppTheme().secondaryColor,
                  size: 33,
                  progress: drawerAnimationController.view,
                ),
              ),
            ),
            actions: [
              Obx((() => 
                AnimatedSmoothIndicator(
                activeIndex: _selectedEvent.value,
                count: events.length,
                effect: WormEffect(
                  activeDotColor: AppTheme().kSecondaryColor,
                  dotHeight: 6.0.sp,
                  dotWidth: 6.0.sp,
                ),
              )
              )),
              SizedBox(width: 15,),
            ],
          );
  }

  Widget eventImage(String image) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30, top: 10),
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
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
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
