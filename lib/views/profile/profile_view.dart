import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/profile/profile_view_content.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../data/response/status.dart';
import '../../utils/utils.dart';
import '../create_new_team.dart';
import '../eventsPage/events_view_content.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

enum ButtonState { init, loading, done }

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin{

  late TabController _tabController;
  ButtonState state = ButtonState.init;
  bool isAnimating = true;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }
  @override
  Widget build(BuildContext context) {
    // final isDone = state == ButtonState.done;
    // final isStretched = isAnimating || state == ButtonState.init;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: selectedAppTheme.isDarkMode?
      AppTheme().backgroundColor_Dark:AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: selectedAppTheme.isDarkMode?
      Brightness.light:Brightness.dark,
    ));

    return Container(
      color: selectedAppTheme.isDarkMode?
      AppTheme().primaryColor_Dark:AppTheme().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: selectedAppTheme.isDarkMode?
          AppTheme().backgroundColor_Dark:AppTheme().backgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled)=>[
              SliverAppBar(
                pinned: true,
                backgroundColor: selectedAppTheme.isDarkMode?
                AppTheme().primaryColor_Dark:AppTheme().primaryColor,
                expandedHeight: SizeConfig.heightPercent*35,
                leading: Center(
                  child: InkWell(
                    onTap: _onDrawerTapped,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      color: Colors.white,
                      size: 33,
                      progress: drawerAnimationController.view,
                    ),
                  ),
                ),
                title: Text("Your Profile",
                  style: AppTheme().headText1.copyWith(
                    fontSize: 20
                  ),
                ),
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(ImagePaths.temp_pic),
                          ),
            
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText("Sriraj",
                                style: AppTheme().headText1.copyWith(
                                  fontSize: 22,
                                ),
                              ),
                              AutoSizeText("palakurthi.sriraj.eee20@itbhu.ac.in",
                                style: AppTheme().headText2,
                              ),
                              AutoSizeText("IIT BHU Varanasi",
                                style: AppTheme().headText2,
                              ),
                              AutoSizeText("+91 8074821478",
                                style: AppTheme().headText2,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: Container(
                    width: double.maxFinite,
                    color: selectedAppTheme.isDarkMode?
                    AppTheme().backgroundColor_Dark:AppTheme().backgroundColor,
                    child: Center(
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            text: "Events",
                          ),
                          Tab(
                            text: "Teams",
                          ),
                          Tab(
                            text: "Requests",
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: MaterialIndicator(
                          color: selectedAppTheme.isDarkMode?
                          AppTheme().kSecondaryColor_Dark:AppTheme().kSecondaryColor,
                          height: 2,
                          topLeftRadius: 8,
                          topRightRadius: 8,
                          bottomLeftRadius: 8,
                          bottomRightRadius: 8,
                          tabPosition: TabPosition.bottom,
                        ),
                        labelColor: selectedAppTheme.isDarkMode?
                        AppTheme().kSecondaryColor_Dark:AppTheme().kSecondaryColor,
                        labelStyle: AppTheme().headText2.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700
                        ),
                        unselectedLabelStyle: AppTheme()
                                  .headText2
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                        unselectedLabelColor: selectedAppTheme.isDarkMode?
                        Colors.white:Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            body: TabBarView(
              controller: _tabController,
              children: [
                buildEventsList(regEvents),
                Stack(
                  children: [
                    buildTeamsList(regTeams),
                    Positioned(
                      bottom: 10,
                      right: 30,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => CreateNewTeam(),
                          ),
                          child: SizedBox(
                              height: 35,
                              width: SizeConfig.width*0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(ImagePaths.add),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  AutoSizeText(
                                      'Create New Team',
                                      style: AppTheme().headText2.copyWith(
                                      )
                                  ),
                                ],
                              )
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: selectedAppTheme.isDarkMode?
                            AppTheme().primaryColor_Dark:AppTheme().primaryColor,
                            fixedSize: Size(SizeConfig.width*0.8, 45),
                            shadowColor: selectedAppTheme.isDarkMode?
                            AppTheme().primaryColor_Dark:AppTheme().primaryColor,
                            elevation: 5,
                          ),
                        ),
                      )
                    )
                  ],
                ),
                buildRequestList(requests)
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget buildRequestList(List<String> requests) {

    if(requests.isEmpty){
      return const Center(
        child: Text("You have no pending requests"),
      );
    }

    return ListView.separated(
      itemBuilder: (context,index){
        return RequestWidget(requests[index]);
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>Center(
          child: Container(
            height: 0,
            width: SizeConfig.widthPercent*90,
            color: Colors.grey,
          )
      ),
      itemCount: requests.length,
    );
  }

  Widget RequestWidget(String teamName) {
    final bool isStretched = isAnimating || state == ButtonState.init;
    final bool isDone = state == ButtonState.done;
    return Container(
      margin: EdgeInsets.fromLTRB(35, 20, 35, 10),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme().secondaryColorLight_Dark,
          boxShadow: [BoxShadow(
              color: selectedAppTheme.isDarkMode?
              AppTheme().primaryColor_Dark.withOpacity(0.3):AppTheme().primaryColor.withOpacity(0.3),
              blurRadius: 4.0,
              spreadRadius: 3.0,
              offset: Offset(4, 4)
          )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
          teamName,
          style: AppTheme().headText1.copyWith(
              color: selectedAppTheme.isDarkMode?
              Colors.white:Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 22
          ),
          ),
          Row(
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeIn,
                width: state == ButtonState.init ?  90:40,
                onEnd: () => setState(() => isAnimating = !isAnimating),
                child: isStretched ? AcceptButton() : LoadingTick(isDone),
              ),
              !isPressed? RejectButton() : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget AcceptButton() {
    return ElevatedButton(
      onPressed: () async {
        isPressed = !isPressed;
        setState(() => state = ButtonState.loading);
        await Future.delayed(Duration(seconds: 3));
        setState(() => state = ButtonState.done);
        print("hello lmao dead");
      },
      child: FittedBox(
        child: AutoSizeText(
          'Accept',
          style: AppTheme().headText2.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: selectedAppTheme.isDarkMode?
        AppTheme().secondaryColor_Dark:AppTheme().secondaryColor,
        shadowColor: selectedAppTheme.isDarkMode?
        AppTheme().primaryColor_Dark:AppTheme().primaryColor,
        elevation: 5,
        fixedSize: Size(80, 30),
      ),
    );
  }

  Widget RejectButton() {
    return GestureDetector(
      onTap: () {
        /// TODO: Implement Reject Request -Sriraj
      },
      child: Container(
        margin: EdgeInsets.only(left: 5),
        height: 13,
        width: 13,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePaths.cancel),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }

  // Widget RejectButton() {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       setState(() => state = ButtonState.loading);
  //       await Future.delayed(Duration(seconds: 3));
  //       setState(() => state = ButtonState.done);
  //       await Future.delayed(Duration(seconds: 3));
  //       setState(() => state = ButtonState.init);
  //
  //     },
  //     child: AutoSizeText(
  //       'Reject',
  //       style: AppTheme().headText2.copyWith(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w400,
  //           ),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(20),
  //         bottomRight: Radius.circular(20),
  //       )),
  //       backgroundColor: Colors.red,
  //       shadowColor: Colors.redAccent,
  //       elevation: 5,
  //       fixedSize: Size(80, 30),
  //     ),
  //   );
  // }
  Widget LoadingTick(bool isDone) {
    final color = isDone ? Colors.green[800] : selectedAppTheme.isDarkMode?
    AppTheme().primaryColor_Dark:AppTheme().primaryColor;
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

  // Widget LoadingCancel(bool isDone){
  //   final color = isDone ? Colors.red[700] : AppTheme().primaryColor;
  //   return Container(
  //     decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  //     child: Center(
  //       child: isDone ? Icon(Icons.cancel_outlined, size: 20, color: Colors.white,):CircularProgressIndicator(color: Colors.white),
  //
  //     ),
  //   );
  // }

  bool isExpanded = false;

  Widget buildTeamsList(List<List<dynamic>> teamsList) {

    if(teamsList.isEmpty){
      return Center(
        child: Text("You have no registered event",
        style: AppTheme()
              .headText2
              .copyWith(fontSize: 17, color: selectedAppTheme.isDarkMode?
        AppTheme().secondaryColor_Dark:AppTheme().secondaryColor),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context,index){
        return TeamsWidget(
            eventImage: regTeams[index][0],
            teamName: regTeams[index][1],
            teamMembers: regTeams[index][2],
        );
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>Center(
          child: Container(
            height: 0,
            width: SizeConfig.widthPercent*90,
            color: Colors.grey,
          )
      ),
      itemCount: regTeams.length,
    );
  }

  Widget TeamsWidget(
      {required String eventImage,
      required String teamName,
      required List<String> teamMembers}) {
    return GestureDetector(
      onTap: () {
        /// TODO: Implement onTap
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 20, 40, 0),
        color: Colors.transparent,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedAppTheme.isDarkMode?
                      AppTheme().secondaryColorLight_Dark:AppTheme().secondaryColorLight,
                      boxShadow: [BoxShadow(
                          color: selectedAppTheme.isDarkMode?
                          AppTheme().primaryColor_Dark.withOpacity(0.3)
                          :AppTheme().primaryColor.withOpacity(0.3),
                          blurRadius: 4.0,
                          spreadRadius: 3.0,
                          offset: Offset(4, 4)
                      )]
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent
                    ),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.topLeft,
                      title: AutoSizeText(
                        teamName,
                        style: AppTheme().headText1.copyWith(
                          color: selectedAppTheme.isDarkMode?
                          Colors.white:Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                      children: [
                        Column(
                          children: [
                            for(var e in teamMembers) 
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_rounded,color: AppTheme().kSecondaryColor),
                                    Text(e,
                                      style: AppTheme().headText2.copyWith(
                                        color: selectedAppTheme.isDarkMode?
                                        Colors.white:Colors.black,
                                        fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                              ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              child: ElevatedButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => CreateNewTeam(),
                                ),
                                child: SizedBox(

                                    height: 35,
                                    width: SizeConfig.width*0.8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(ImagePaths.add),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FittedBox(
                                          child: Text(
                                              'Add Member',
                                              style: AppTheme().headText2.copyWith(
                                                fontSize: 15
                                                  
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  backgroundColor: selectedAppTheme.isDarkMode?
                                  AppTheme().secondaryColor_Dark:AppTheme().secondaryColor,
                                  fixedSize: Size(SizeConfig.width*0.35, 20),
                                  shadowColor: selectedAppTheme.isDarkMode?
                                  AppTheme().primaryColor_Dark:AppTheme().primaryColor,
                                  elevation: 5,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ],
                      onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: SizeConfig.height*0.05,
                  width: SizeConfig.height*0.05,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(eventImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                          color: selectedAppTheme.isDarkMode?
                          AppTheme().secondaryColor_Dark:AppTheme().secondaryColor,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(3, 3)
                      )]
                  ),
                )
              ]
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }


  Widget buildEventsList(List<List<String>> regEvents) {

    if(regEvents.isEmpty){
      return Center(
        child: Text("You have no registered events!!",
          style: AppTheme().headText2.copyWith(
            fontSize: 17,
            color: selectedAppTheme.isDarkMode?
            AppTheme().secondaryColor_Dark:AppTheme().secondaryColor
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context,index){
        return RegEvents(
           eventImage: regEvents[index][0],
           eventName: regEvents[index][1],
           teamName: regEvents[index][2],
           stage: regEvents[index][3],
           score: regEvents[index][4],
           date: regEvents[index][5]
        );
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>Center(
          child: Container(
            height: 0,
            width: SizeConfig.widthPercent*90,
            color: Colors.grey,
          )
      ),
      itemCount: regEvents.length,
    );
  }

  Widget RegEvents(
      {required String eventImage,
      required String eventName,
      required String teamName,
      required String stage,
      required String score,
      required String date}) {
    return GestureDetector(
      onTap: () {
        /// TODO: Implement onTap
      },
      child: Container(
        height: SizeConfig.height*0.2,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 45,
                child: Container(
                  height: SizeConfig.height*0.145,
                  width: SizeConfig.width*0.68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: selectedAppTheme.isDarkMode?
                      AppTheme().secondaryColorLight_Dark:AppTheme().secondaryColorLight,
                      boxShadow: [BoxShadow(
                          color: selectedAppTheme.isDarkMode?
                          AppTheme().primaryColor_Dark.withOpacity(0.3)
                          :AppTheme().primaryColor.withOpacity(0.3),
                          blurRadius: 4.0,
                          spreadRadius: 3.0,
                          offset: Offset(4, 4)
                      )]
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.width*0.6,
                        padding: EdgeInsets.only(top: 10, left: 55),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  eventName,
                                  style: AppTheme().headText1.copyWith(
                                      color: selectedAppTheme.isDarkMode?
                                      Colors.white:Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                AutoSizeText(
                                  teamName,
                                  style: AppTheme().headText2.copyWith(
                                      fontSize: 16,
                                      color: selectedAppTheme.isDarkMode?
                                      AppTheme().primaryColor_Dark:AppTheme().primaryColor
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: SizeConfig.height*0.0175,
                                        width: SizeConfig.height*0.0259,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(ImagePaths.score),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                      
                                      AutoSizeText(
                                          score,
                                          style: AppTheme().headText2.copyWith(
                                            color: selectedAppTheme.isDarkMode?
                                            Colors.white:Colors.black
                                          )
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: SizeConfig.height*0.02,
                                        width: SizeConfig.height*0.02,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(ImagePaths.calender),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AutoSizeText(
                                          date,
                                          style: AppTheme().headText2.copyWith(
                                            color: selectedAppTheme.isDarkMode?
                                            Colors.white:Colors.black
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
                top: 15,
                left: 10,
                child: Container(
                  height: SizeConfig.height*0.10,
                  width: SizeConfig.height*0.10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(eventImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: selectedAppTheme.isDarkMode?
                      AppTheme().secondaryColor_Dark:AppTheme().secondaryColor,
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: Offset(4, 4)
                    )]
                  ),
                )
            ),
          ],
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
