import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/login_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../homePage/homeView.dart';
import 'login_view_content.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  int _currentPage = 0;

  LoginViewAnimation loginAnimation = LoginViewAnimation();
  late final animationController;
  late Timer _timer;
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    animationController = Get.put(loginAnimation);
    loginAnimation.initiatePageAnimation(this);
    _pageController = PageController(initialPage: 0);
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _startTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (_pageController.page! >= images.length - 1) {
        timer.cancel();
        // _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {

    // _timer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
    //   if (_pageController.page! >= images.length - 1) {
    //     timer.cancel();
    //   } else {
    //     _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
    //   }
    // });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().secondaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: ScreenUtilInit(
        builder: (context, child) =>
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        AppTheme().primaryColor,
                        AppTheme().primaryColor,
                        AppTheme().secondaryColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.sp,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 4),
                    builder: ((context, double value, child) =>
                        Opacity(
                          opacity: value,
                          child: child,
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePaths.prastuti_logo_1,
                          height: SizeConfig.height * 0.075,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onHorizontalDragCancel: () {
                      _timer.cancel();
                    },
                    child: Container(
                      height: SizeConfig.heightPercent * 70,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (int page) {
                          loginAnimation.restartPageAnimation();
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return (_currentPage != index)?Container()
                              :Column(
                              children: [
                                SizedBox(height: 20.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                          () =>
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: (1.0 - animationController
                                                  .pagePaddingValue.value) *
                                                  100,
                                            ),
                                            child: Opacity(
                                              opacity: animationController
                                                  .pagePaddingValue.value,
                                              child: Container(
                                                height: SizeConfig.height*0.3,
                                                width: SizeConfig.width*0.7,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(32),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppTheme().primaryColorLight,
                                                      spreadRadius: 5,
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 5),

                                                    ),
                                                  ],
                                                ),
                                                child: FittedBox(
                                                  child: Image.asset(
                                                      images[index]
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.heightPercent*8.sp),
                                Obx(
                                      () =>
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: (1.0 - animationController
                                                .pagePaddingValue.value) * SizeConfig.heightPercent*6),
                                        child: Opacity(
                                          opacity: animationController
                                              .pagePaddingValue.value,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                height: SizeConfig.height*0.07,
                                                width: SizeConfig.width*0.8,
                                                child: AutoSizeText(
                                                  title[index],
                                                  style: AppTheme().headText1.copyWith(
                                                      fontWeight: FontWeight.w900
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig.height * 0.15,
                                                width: SizeConfig.width * 0.80,
                                                child: AutoSizeText(
                                                  detail[index],
                                                  style: AppTheme().headText2.copyWith(
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                ),
                              ]
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentPage,
                            count: 4,
                            effect: WormEffect(
                              activeDotColor: AppTheme().kSecondaryColor,
                              dotHeight: 6.0,
                              dotWidth: 6.0,
                            ),
                          ),
                        ),
                        Consumer(builder: (context, ref, child) {
                          bool isLoading = ref.watch(isLoggingIn);
                          return (SignInButton(
                              _currentPage, ref, context, isLoading));
                        })
                      ],
                    ),
                  ),

                ],
              ),
            ),
        //designSize: const Size(375.0, 728.0),
      ),
    );
  }
  Widget SignInButton(
      int page,
      WidgetRef ref,
      BuildContext context,
      bool isLoading,
      ) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: (page <3 )?ElevatedButton(
          onPressed: () {
            _timer.cancel();
            _pageController.jumpToPage(images.length - 1);
          },
          child: Center(
            child: Text(
              'SKIP',
              style: AppTheme().headText1.copyWith(
                  fontSize: 20
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
                  backgroundColor: AppTheme().primaryColorDark,
                  fixedSize: Size(140.sp, 50.sp),
                  shadowColor: AppTheme().primaryColorExtraDark,
                  elevation: 0.sp,
          ),
        ): ElevatedButton(
          onPressed: () async {
            await ref.read(isLoggingIn.notifier)
                .login(context: context);
            // isLoggedIn.isLogged = !isLoggedIn.isLogged;
            // isLoggedIn.saveAuth(isLoggedIn.isLogged);
          },
          child: isLoading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 15,
                width: 15,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Please Wait...",
                style: AppTheme().headText2.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              )
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 35.sp,
                  width: 35.sp,
                  child: Image.asset(ImagePaths.google_logo)
              ),
              Container(
                width: 10.sp,
              ),
              FittedBox(
                child: Text(
                  "Log In",
                  style: AppTheme().headText2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: AppTheme().primaryColorDark,
            fixedSize: Size(140.sp, 50.sp),
            shadowColor: AppTheme().primaryColorExtraDark,
            elevation: 15.sp,
          ),
        )
    );
  }

  Future<bool> _onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasBeenPressedTwice = backButtonPressTime != null &&
        currentTime.difference(backButtonPressTime) > const Duration(seconds: 2);

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
}
