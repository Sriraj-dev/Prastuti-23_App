
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:prastuti_23/view_models/home_view_model.dart';
import 'package:prastuti_23/views/eventsPage/events_view.dart';


//TODO: Beautify This Widget if possible:

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedAppTheme.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10).copyWith(bottom: 18),
          child: Column(
            children: [
              SizedBox(height: 5,),
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
                        color: selectedAppTheme.isDarkMode?
                        Colors.white:AppTheme().secondaryColor
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: ()=>homeViewController.changeSelectedView(0),
                title: Text("Events",
                  style: AppTheme().headText2.copyWith(
                    color: selectedAppTheme.isDarkMode?
                    Colors.white:Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),),
                leading: Icon(
                  Icons.event_note_rounded,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              ListTile(
                onTap: () =>homeViewController.changeSelectedView(1),
                title: Text("Profile",
                    style: AppTheme().headText2.copyWith(
                      color: selectedAppTheme.isDarkMode?
                      Colors.white:Colors.black,
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
                      color: selectedAppTheme.isDarkMode?
                      Colors.white:Colors.black,
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
                      color: selectedAppTheme.isDarkMode?
                      Colors.white:Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    )),
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: AppTheme().kSecondaryColor,
                ),
              ),
              SizedBox(height: 5,),
              Consumer(builder: (context, ref, child) {
                bool isLoading = ref.watch(isLoggingIn);
                return InkWell(
                  onTap: () async {
                    await ref.read(isLoggingIn.notifier)
                        .logout(context: context);
                  },
                  child: Container(
                    height: SizeConfig.heightPercent * 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme().primaryColor
                    ),
                    child: Center(
                      child: (isLoading)?SizedBox(
                          width: SizeConfig.heightPercent * 3.5,
                          height: SizeConfig.heightPercent * 3.5,
                          child: const SpinKitSpinningLines(color: Colors.white)
                      ):Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
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
}


