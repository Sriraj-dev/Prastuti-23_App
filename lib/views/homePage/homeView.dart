import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/home_view_model.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/views/contactUsPage/contact_us.dart';
import 'package:prastuti_23/views/eventsPage/events_view.dart';
import 'package:prastuti_23/views/profile/profile_view.dart';

import '../../config/image_paths.dart';
import '../../view_models/auth_view_model.dart';
import '../aboutUs/about_us.dart';

DateTime backButtonPressTime = DateTime.now();

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{




  HomeViewAnimation homeViewAnimation = HomeViewAnimation();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
    homeViewAnimation.initiateHomeAnimation(this);
  }


  @override
  Widget build(BuildContext context) {

      List<Widget> views = [
      EventsView(),
      ProfileView(),
      ContactUsView(),
      AboutUsView(),
    ];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: selectedAppTheme.isDarkMode?
      Brightness.light:Brightness.dark,
    ));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedBuilder(
        animation: drawerAnimationController,
        child: NavDrawer(),
        builder: (context,child){
          return Scaffold(
            appBar: (homeViewController.selectedView == 1 || homeViewController.selectedView==0)?null:
            AppBar(
              elevation: 0,
              backgroundColor: AppTheme().backgroundColor.withOpacity(opacityAnimation.value),
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
              )
            ),

            body: Stack(
              children: [
                //We have Our View Pages Here :
                Obx(() => Opacity(
                  opacity: opacityAnimation.value,
                  child: GestureDetector(
                    onTap: (){
                      if(drawerAnimationController.isCompleted)
                        drawerAnimationController.reverse();
                    },
                    child: views[homeViewController.selectedView]
                    )
                  ),
                ),


                //This is the CustomDrawer :
                Positioned(
                  left: drawerAnimation.value,
                  top: (homeViewController.selectedView == 1 ||
                            homeViewController.selectedView == 0)?SizeConfig.heightPercent*15:
                  SizeConfig.heightPercent*7,
                  child: Opacity(
                    opacity: drawerAnimationController.value,
                    child: child,
                  )
                )
              ]
            ),
          );
        }
      ),
    );
  }

  Future<bool> _onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasBeenPressedTwice = backButtonPressTime != null &&
        currentTime.difference(backButtonPressTime) > Duration(seconds: 2);

    if (backButtonHasBeenPressedTwice) {
      SystemNavigator.pop();
      return false;
    } else {
      backButtonPressTime = currentTime;
      Fluttertoast.showToast(
          msg: "Press again to exit the App",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
  }

  void _onDrawerTapped(){
    if(drawerAnimationController.isCompleted){
      drawerAnimationController.reverse();
    }else{
      drawerAnimationController.forward();
    }
  }

  Widget NavDrawer() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        //height: SizeConfig.heightPercent * 50,
        width: SizeConfig.widthPercent * 62,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme().backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              .copyWith(bottom: 18),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    ImagePaths.prastuti_logo,
                    scale: 1.2,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Prastuti' 23",
                    style: AppTheme().headText2.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: selectedAppTheme.isDarkMode
                            ? Colors.white
                            : AppTheme().secondaryColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  themeChange(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () => homeViewController.changeSelectedView(0),
                title: Text(
                  "Events",
                  style: AppTheme().headText2.copyWith(
                        color: selectedAppTheme.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                ),
                leading: Icon(
                  Icons.event_note_rounded,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              ListTile(
                onTap: () => homeViewController.changeSelectedView(1),
                title: Text("Profile",
                    style: AppTheme().headText2.copyWith(
                          color: selectedAppTheme.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                leading: Icon(
                  Icons.person,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              ListTile(
                onTap: () => homeViewController.changeSelectedView(2),
                title: Text("Contact us",
                    style: AppTheme().headText2.copyWith(
                          color: selectedAppTheme.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                leading: Icon(
                  Icons.phone,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              ListTile(
                onTap: () => homeViewController.changeSelectedView(3),
                title: Text("About us",
                    style: AppTheme().headText2.copyWith(
                          color: selectedAppTheme.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        )),
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Consumer(builder: (context, ref, child) {
                bool isLoading = ref.watch(isLoggingIn);
                return InkWell(
                  onTap: () async {
                    await ref
                        .read(isLoggingIn.notifier)
                        .logout(context: context);
                    // isLoggedIn.isLogged = !isLoggedIn.isLogged;
                    // isLoggedIn.saveAuth(isLoggedIn.isLogged);
                  },
                  child: Container(
                    height: SizeConfig.heightPercent * 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme().primaryColor),
                    child: Center(
                      child: (isLoading)
                          ? SizedBox(
                              width: SizeConfig.heightPercent * 3.5,
                              height: SizeConfig.heightPercent * 3.5,
                              child: const SpinKitSpinningLines(
                                  color: Colors.white))
                          : Text(
                              "Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeChange() {
    return GestureDetector(
      onTap: () async {
        setState(() {
         selectedAppTheme.isDarkMode = !selectedAppTheme.isDarkMode;
         selectedAppTheme.saveMode(selectedAppTheme.isDarkMode);
        });
        //Navigator.pop(context);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: selectedAppTheme.isDarkMode
                    ? AssetImage('assets/sun.png')
                    : AssetImage('assets/moon.png'),
                fit: BoxFit.cover),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}