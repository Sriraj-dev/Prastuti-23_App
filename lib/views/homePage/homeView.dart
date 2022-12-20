import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/AboutUs/about_us.dart';
import 'package:prastuti_23/views/eventsPage/events_view.dart';
import 'package:prastuti_23/views/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{

  late AnimationController _drawerAnimationController;
  late Animation _opacityAnimation;
  late Animation<double> _drawerAnimation;

  RxInt _selectedView = 0.obs;

  List<Widget> views = [
    EventsView(),
    ProfileView(),
    AboutUsView(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SizeConfig.init(context);
  }

  @override
  void initState() {
    super.initState();

    _drawerAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    //TODO: Decide a Proper Curve
    _drawerAnimation = Tween<double>(begin: -300,end: 20).animate(CurvedAnimation(
      parent: _drawerAnimationController,
      curve: Curves.fastLinearToSlowEaseIn)
    );
    _opacityAnimation =
        Tween<double>(begin: 1, end: 0.2).animate(_drawerAnimationController);
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _drawerAnimationController,
      child: drawer(),
      builder: (context,child){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppTheme().backgroundColor.withOpacity(_opacityAnimation.value),
            leading: Center(
              child: InkWell(
                onTap: _onDrawerTapped,
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: AppTheme().secondaryColor,
                  size: 33,
                  progress: _drawerAnimationController.view,
                ),
              ),
            )
          ),

          body: Stack(
            children: [
              //We have Our View Pages Here :
              Obx(() => Opacity(
                opacity: _opacityAnimation.value,
                child: views[_selectedView.value]),),


              //This is the CustomDrawer :
              Positioned(
                left: _drawerAnimation.value,
                top: SizeConfig.heightPercent*10,
                child: Opacity(
                  opacity: _drawerAnimationController.value,
                  child: child,
                )
              )
            ]
          ),
        );
      }
    );
  }

  Widget drawer(){
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: SizeConfig.heightPercent*50,
        width: SizeConfig.widthPercent*65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme().backgroundColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightPercent*40,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Image.asset(ImagePaths.prastuti_logo,scale: 1.5,),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Prastuti' 23",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme().secondaryColor
                                ),
                              ),
                              Text("Annual Departmental fest",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  overflow: TextOverflow.fade
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      onTap: (){
                        _selectedView.value = 0;
                      },
                      title: Text("Events"),
                      leading: Icon(Icons.event_note_rounded,
                      color: AppTheme().secondaryColor,),
                    ),
                    ListTile(
                      onTap: (){
                        _selectedView.value = 1;
                      },
                      title: Text("Profile"),
                      leading: Icon(Icons.person,
                      color: AppTheme().secondaryColor,),
                    ),
                    ListTile(
                      onTap: () {
                        _selectedView.value = 2;
                      },
                      title: Text("About us"),
                      leading: Icon(
                        Icons.info_outline_rounded,
                        color: AppTheme().secondaryColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text("Contact us"),
                      leading: Icon(
                        Icons.phone,
                        color: AppTheme().secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.heightPercent*5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTheme().primaryColor),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  void _onDrawerTapped(){
    if(_drawerAnimationController.isCompleted){
      _drawerAnimationController.reverse();
    }else{
      _drawerAnimationController.forward();
    }
  }
}