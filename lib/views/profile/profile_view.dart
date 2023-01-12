import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/models/eventListModel.dart';
import 'package:prastuti_23/models/teamsModel.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:prastuti_23/view_models/profile_view_model.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../utils/utils.dart';
import '../eventsPage/events_view_content.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

enum ButtonState { init, loading, done }

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late TabController _tabController;
   RxBool creatingTeam = false.obs;
   RxBool sendingRequest = false.obs;
   RxList<bool> isAcceptingRequest = <bool>[].obs;
   RxList<bool> isRejectingRequest = <bool>[].obs;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    currentUser.pendingRequests!.forEach((element) {
      isAcceptingRequest.add(false);
      isRejectingRequest.add(false);
    });
    ProfileViewModel().buildRegisteredEventsDetails(currentUser.eventsParticipated!);
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
      systemNavigationBarIconBrightness:
          selectedAppTheme.isDarkMode ? Brightness.light : Brightness.dark,
    ));

    return Container(
      color: AppTheme().primaryColor,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: selectedAppTheme.isDarkMode?
                  AssetImage(ImagePaths.bgImage_dark):AssetImage(ImagePaths.bgImage_light),
                  fit: BoxFit.cover
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: ((context, innerBoxIsScrolled)=>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppTheme().primaryColor,
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
                      color: AppTheme().backgroundColor,
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
                            color: AppTheme().kSecondaryColor,
                            height: 2,
                            topLeftRadius: 8,
                            topRightRadius: 8,
                            bottomLeftRadius: 8,
                            bottomRightRadius: 8,
                            tabPosition: TabPosition.bottom,
                          ),
                          labelColor: AppTheme().kSecondaryColor,
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
                  buildEventsList(currentUser.eventsParticipated!),
                  Stack(
                    children: [
                      buildTeamsList(currentUser.teams!),
                      Positioned(
                          bottom: 10,
                          right: 30,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => Utils.DialogBox(
                                      context,
                                      'Create New Team',
                                      'Enter Team Name',
                                      'Create',
                                      true)
                                    ).then((value)async{
                                      if(value!=null){
                                        if(value.isEmpty){
                                          Utils.flushBarMessage(
                                            context: context,
                                            bgColor: Colors.redAccent,
                                            message: "Please enter a Valid Team name!"
                                          );
                                          return ;
                                        }
                                        creatingTeam.value = true;
                                        await ProfileViewModel().createTeam(
                                          teamName: value, userId: currentUser.sId!, context: context);
                                        creatingTeam.value = false;
                                      }
                                    });
                              },
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
                                      Obx((){
                                          return (creatingTeam.value)?
                                          SpinKitWave(
                                            color: Colors.white,
                                            itemCount: 5,
                                            size: 15,
                                          )
                                          :AutoSizeText(
                                            'Create New Team',
                                            style: AppTheme().headText2.copyWith(
                                            )
                                        );
                                      })
                                      ,
                                    ],
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: AppTheme().primaryColor,
                                fixedSize: Size(SizeConfig.width*0.8, 45),
                                shadowColor: AppTheme().primaryColor,
                                elevation: 5,
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  buildRequestList(currentUser.pendingRequests!)
                ]
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRequestList(List<PendingRequests> requests) {

    if(requests.isEmpty){
      return const Center(
        child: Text("You have no pending requests"),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return RequestWidget(requests[index].sId!,requests[index].sId!,index);
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Center(
          child: Container(
        height: 0,
        width: SizeConfig.widthPercent * 90,
        color: Colors.grey,
      )),
      itemCount: requests.length,
    );
  }

  Widget RequestWidget(String teamName,String requestId,int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 20, 35, 10),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme().secondaryColorLight,
          boxShadow: [
            BoxShadow(
                color: AppTheme().primaryColor.withOpacity(0.3),
                blurRadius: 4.0,
                spreadRadius: 3.0,
                offset: Offset(4, 4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: AutoSizeText(
              teamName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme().headText1.copyWith(
                  color: selectedAppTheme.isDarkMode?
                  Colors.white:Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),),
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeIn,
                width:90,
                child:AcceptButton(requestId,index),
              ),
              RejectButton(requestId,index)
            ],
          ),
        ],
      ),
    );
  }

  Widget AcceptButton(String requestId,int index) {
    return ElevatedButton(
      onPressed: () async {
        isAcceptingRequest[index] = true;
        await ProfileViewModel().acceptRequest(requestId, context);
        isAcceptingRequest[index] = false;
      },
      child: FittedBox(
        child: Obx((){
          return (isAcceptingRequest[index])?
          const Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 8,
              itemCount: 3,
            ),
          )
          :AutoSizeText(
            'Accept',
            style: AppTheme().headText2.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
          );
        }),
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

  Widget RejectButton(String requestId,int index) {
    return GestureDetector(
      onTap: () async{
         isRejectingRequest[index] = true;
        await ProfileViewModel().rejectRequest(requestId, context);
        isRejectingRequest[index] = false;
      },
      child: Obx((){
        return (isRejectingRequest[index])?
        SpinKitCircle(
          color: AppTheme().primaryColor,
          size: 14,
        )
        :Container(
        margin: const EdgeInsets.only(left: 5),
        height: 13,
        width: 13,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: selectedAppTheme.isDarkMode?
                AssetImage(ImagePaths.cancel_dark):AssetImage(ImagePaths.cancel_light),
                fit: BoxFit.cover
            )
          ),
        );
      }),
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

  // bool isExpanded = false;

  Widget buildTeamsList(List<Teams> teamsList) {
    if (teamsList.isEmpty) {
      return Center(
        child: Text(
          "You have not joined in any team yet!!",
          style: AppTheme()
              .headText2
              .copyWith(fontSize: 17, color: selectedAppTheme.isDarkMode?
        Colors.white:AppTheme().secondaryColor),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return TeamsWidget(
          eventImage: (index%3==0)?
          ImagePaths.events:(index%3==1)?
          ImagePaths.awards:
           ImagePaths.events,
          teamName: teamsList[index].teamName!,
          teamMembers: teamsList[index].members!,
          teamId: teamsList[index].sId!,
        );
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Center(
          child: Container(
        height: 0,
        width: SizeConfig.widthPercent * 90,
        color: Colors.grey,
      )),
      itemCount: teamsList.length,
    );
  }

  Widget TeamsWidget(
      {required String eventImage,
      required String teamName,
      required List<Members> teamMembers,
      required String teamId}) {
    return GestureDetector(
      onTap: () {
        /// TODO: Implement onTap
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 20, 40, 0),
        color: Colors.transparent,
        child: Column(
          children: [
            Stack(children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme().secondaryColorLight,
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
                    iconColor: selectedAppTheme.isDarkMode
                        ? Colors.white
                        : Colors.black,
                    collapsedIconColor: selectedAppTheme.isDarkMode
                        ? Colors.white
                        : Colors.black,
                    expandedAlignment: Alignment.topLeft,
                    title: AutoSizeText(
                      teamName,
                      style: AppTheme().headText1.copyWith(
                          color: selectedAppTheme.isDarkMode
                              ? Colors.white
                              : Colors.black,
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
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(e.name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                          style: AppTheme().headText2.copyWith(
                                            color: selectedAppTheme.isDarkMode?
                                            Colors.white:Colors.black,
                                            fontSize: 16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55,vertical: 5),
                              child: ElevatedButton(
                                  onPressed: (){
                                      showDialog(
                                    context: context,
                                    builder: (context) => Utils.DialogBox(
                                        context,
                                        'Add New Member',
                                        'Enter Email ID',
                                        'Add',
                                        false
                                      )
                                  ).then((value)async{
                                    if(value == null) return ;
                                      if(value.isEmpty){
                                        Utils.flushBarMessage(
                                          context: context,
                                          bgColor: Colors.redAccent,
                                          message:
                                              "Please enter a Valid Email Id");
                                      }
                                    sendingRequest.value = true;
                                    await ProfileViewModel().sendTeamRequest(
                                      email: value, 
                                      userId: currentUser.sId!,
                                      teamId: teamId,
                                      context: context);
                                  sendingRequest.value = false;
                                  });
                                },
                                child: SizedBox(
                                    height: 35,
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
                                        Obx((){
                                          return (sendingRequest.value)?
                                          const SpinKitWave(
                                            color: Colors.white,
                                            itemCount: 5,
                                            size: 15,
                                          )
                                          :Text(
                                            'Add Member',
                                            style: AppTheme().headText2.copyWith(
                                              fontSize: 15
                                            )
                                          );
                                        }),
                                      ],
                                    )
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  backgroundColor: AppTheme().secondaryColor,
                                 // fixedSize: Size(SizeConfig.width*0.35, 20),
                                  shadowColor: AppTheme().primaryColor,
                                  elevation: 5,

             
                                ),
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ],
                      //onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
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

  Widget buildEventsList(List<Events> regEvents) {
    if (regEvents.isEmpty) {
      return Center(
        child: Text("You have no registered events!!",
          style: AppTheme().headText2.copyWith(
            fontSize: 17,
            color: selectedAppTheme.isDarkMode?
            Colors.white:AppTheme().secondaryColor
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return RegEvents(
            eventImage: event_images[(regEvents[index].name!).toUpperCase()]!,
            eventName: regEvents[index].name!,
            teamName: joinedAs[index],
            stage: "Not Used",
            score: scoreInEvent[index],
            date: startDate[index]);
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Center(
          child: Container(
        height: 0,
        width: SizeConfig.widthPercent * 90,
        color: Colors.grey,
      )),
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
        height: SizeConfig.height * 0.2,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 45,
                child: Container(
                  height: SizeConfig.height * 0.145,
                  width: SizeConfig.width * 0.68,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppTheme().secondaryColorLight,
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme().primaryColor.withOpacity(0.3),
                            blurRadius: 4.0,
                            spreadRadius: 3.0,
                            offset: Offset(4, 4))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.width * 0.6,
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
                                      color: selectedAppTheme.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                AutoSizeText(
                                  teamName,
                                  style: AppTheme().headText2.copyWith(
                                      fontSize: 16,
                                      color: AppTheme().primaryColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: SizeConfig.height * 0.025,
                                        width: SizeConfig.height * 0.0259,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    ImagePaths.score),
                                                fit: BoxFit.fill)),
                                      ),
                                      AutoSizeText(" "+score,
                                          style: AppTheme().headText2.copyWith(
                                              color: selectedAppTheme.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: SizeConfig.height * 0.02,
                                        width: SizeConfig.height * 0.02,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    ImagePaths.calender),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AutoSizeText(date,
                                          style: AppTheme().headText2.copyWith(
                                              color: selectedAppTheme.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black)),
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
                )),
            Positioned(
                top: 15,
                left: 10,
                child: Container(
                  height: SizeConfig.height * 0.10,
                  width: SizeConfig.height * 0.10,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(eventImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme().secondaryColor,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            offset: Offset(4, 4))
                      ]),
                )),
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
