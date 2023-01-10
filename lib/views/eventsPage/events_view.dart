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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Container(
      color: AppTheme().backgroundColor,
      child: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final allEventsList = ref.watch(eventsProvider);
          return allEventsList.when(
            error: ((e, stackTrace) => const ErrorView()),
            loading: () => const Events_view_skeleton(),
            data: (allEvents) {
              List<Events> events = allEvents.events as List<Events>;
              return Scaffold(
                backgroundColor: AppTheme().backgroundColor,
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
                                            color: AppTheme().primaryColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      27))),
                                              builder: (context) =>
                                                  buildTeamtList(requests));
                                        },
                                        child: AutoSizeText(
                                          'Register',
                                          style: AppTheme().headText2.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor:
                                              AppTheme().kSecondaryColor,
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
                                                      color: AppTheme()
                                                          .secondaryColor),
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
                                                    color: AppTheme()
                                                        .kSecondaryColor,
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
                                                            color: AppTheme()
                                                                .secondaryColor),
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
                                                    color: AppTheme()
                                                        .kSecondaryColor,
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
                                                            color: AppTheme()
                                                                .secondaryColor),
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
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: AppTheme()
                                                            .primaryColor,
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
                                              title: Text(
                                                "Rules",
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: AppTheme()
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              children: [
                                                Text(
                                                    events[_selectedEvent.value]
                                                            .rules ??
                                                        "")
                                              ],
                                            ),
                                          ),
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              title: Text(
                                                "Rewards",
                                                style: AppTheme()
                                                    .headText2
                                                    .copyWith(
                                                        color: AppTheme()
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              children: [
                                                Text(
                                                    events[_selectedEvent.value]
                                                            .rewards ??
                                                        "")
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
      backgroundColor:
          AppTheme().backgroundColor.withOpacity(opacityAnimation.value),
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
        Obx((() => AnimatedSmoothIndicator(
              activeIndex: _selectedEvent.value,
              count: events.length,
              effect: WormEffect(
                activeDotColor: AppTheme().kSecondaryColor,
                dotHeight: 6.0.sp,
                dotWidth: 6.0.sp,
              ),
            ))),
        SizedBox(
          width: 15,
        ),
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

  Widget EventsTeamsWidget(String teamName) {
    // final bool isStretched = isAnimating || state == ButtonState.init;
    // final bool isDone = state == ButtonState.done;
    return Container(
        margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 181, 200, 232),
            boxShadow: [
              BoxShadow(
                  color: AppTheme().primaryColor.withOpacity(0.3),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                  offset: Offset(4, 4))
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AutoSizeText(
            teamName,
            style: AppTheme().headText1.copyWith(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
          ),
              AcceptButton()
        ]));
  }

  Widget AcceptButton() {
    return ElevatedButton(
      onPressed: () async {
        // isPressed = !isPressed;
        // setState(() => state = ButtonState.loading);
        // await Future.delayed(Duration(seconds: 3));
        // setState(() => state = ButtonState.done);
        print("hello lmao dead");
      },
      child: FittedBox(
        child: AutoSizeText(
          'Join',
          style: AppTheme().headText2.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: AppTheme().secondaryColor,
        shadowColor: AppTheme().primaryColor,
        elevation: 5,
        fixedSize: Size(80, 30),
      ),
    );
  }

  Widget LoadingTick(bool isDone) {
    final color = isDone ? Colors.green[800] : AppTheme().primaryColor;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? Icon(
                Icons.done,
                size: 30,
                color: Colors.white,
              )
            : CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget buildTeamtList(List<String> requests) {
    if (requests.isEmpty) {
      return const Center(
        child: Text("You have no pending requests"),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 10,
          child: Column(
            children: [
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Select a Team to register",
                style: AppTheme().headText1.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 27),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return EventsTeamsWidget(requests[index]);
            },
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Center(
                child: Container(
              height: 0,
              width: SizeConfig.widthPercent * 90,
              color: Colors.grey,
            )),
            itemCount: requests.length,
          ),
        )
      ],
    );
  }

 
  bool isExpanded = false;

  Widget TeamsWidget(
      {required String eventImage,
      required String teamName,
      required List<String> teamMembers}) {
    return GestureDetector(
      onTap: () {
        /// TODO: Implement onTap
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 30, 0),
        color: Colors.transparent,
        child: Column(
          children: [
            Stack(children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 181, 200, 232),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme().primaryColor.withOpacity(0.3),
                          blurRadius: 4.0,
                          spreadRadius: 3.0,
                          offset: Offset(4, 4))
                    ]),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.topLeft,
                    title: AutoSizeText(
                      teamName,
                      style: AppTheme().headText1.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                    children: [
                      Column(
                        children: [
                          for (var e in teamMembers)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_rounded,
                                    color: AppTheme().primaryColor,
                                  ),
                                  Text(
                                    e,
                                    style: AppTheme().headText2.copyWith(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_rounded,
                                  color: AppTheme().primaryColor,
                                ),
                                Text(
                                  "New Member",
                                  style: AppTheme().headText2.copyWith(
                                      color: Colors.black, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                    onExpansionChanged: (bool expanding) =>
                        setState(() => this.isExpanded = expanding),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: SizeConfig.height * 0.05,
                width: SizeConfig.height * 0.05,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(eventImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme().secondaryColor,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(3, 3))
                    ]),
              )
            ]),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
