import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/home_view_model.dart';
import 'package:prastuti_23/views/AboutUs/about_us.dart';
import 'package:prastuti_23/views/eventsPage/events_view.dart';
import 'package:prastuti_23/views/homePage/drawer.dart';
import 'package:prastuti_23/views/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{


  List<Widget> views = [
    EventsView(),
    ProfileView(),
    AboutUsView(),
  ];

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
    return AnimatedBuilder(
      animation: drawerAnimationController,
      child: drawer(),
      builder: (context,child){
        return Scaffold(
          appBar: (homeViewController.selectedView == 1)?null:
          AppBar(
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
                  child: views[homeViewController.selectedView])
                ),
              ),


              //This is the CustomDrawer :
              Positioned(
                left: drawerAnimation.value,
                top: (homeViewController.selectedView == 1)?SizeConfig.heightPercent*10:
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
    );
  }

  void _onDrawerTapped(){
    if(drawerAnimationController.isCompleted){
      drawerAnimationController.reverse();
    }else{
      drawerAnimationController.forward();
    }
  }
}