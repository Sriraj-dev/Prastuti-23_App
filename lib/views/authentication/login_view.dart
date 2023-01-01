import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prastuti_23/animations/login_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = Get.put(loginAnimation);
    loginAnimation.initiatePageAnimation(this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
                    child: Container(
                      //padding: EdgeInsets.only(right: 30.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagePaths.prastuti_logo_1,
                            height: SizeConfig.height * 0.09.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Container(
                    height: SizeConfig.heightPercent * 70.sp,
                    child: PageView.builder(
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
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: (1.0 - animationController
                                                  .pagePaddingValue.value) *
                                                  100,
                                            ),
                                            child: Opacity(
                                              opacity: animationController
                                                  .pagePaddingValue.value,
                                              child: Container(                                              
                                                height: SizeConfig.height*0.3.sp,
                                                width: SizeConfig.width*0.7.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(32.sp),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 17, 102, 157),
                                                      spreadRadius: 5.sp,
                                                      blurRadius: 10.sp,
                                                      offset: Offset(0.sp, 5.sp),
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
                                              height: SizeConfig.height*0.07.sp,
                                              width: SizeConfig.width*0.8.sp,
                                              child: AutoSizeText(
                                                title[index],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  decoration: TextDecoration
                                                      .none,
                                                  fontSize: 40.sp,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.height * 0.15.sp,
                                              width: SizeConfig.width * 0.80.sp,
                                              child: AutoSizeText(
                                                detail[index],
                                                style: AppTheme().headText2.copyWith(
                                                    fontWeight: FontWeight
                                                        .normal,
                                                  fontSize: 16.sp,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.sp),
                          child: AnimatedSmoothIndicator(
                            activeIndex: _currentPage,
                            count: 4,
                            effect: WormEffect(
                              activeDotColor: AppTheme().kSecondaryColor,
                              dotHeight: 6.0.sp,
                              dotWidth: 6.0.sp,
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
    );
  }
}

Widget SignInButton(int, WidgetRef, BuildContext, bool) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    child: (int <3 )?ElevatedButton(
      onPressed: () {
        null;
      },
      child: Image.asset(ImagePaths.google_logo),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Color.fromARGB(255, 21, 63, 94),
        fixedSize: Size(50.sp, 50.sp),
        shadowColor: Color.fromARGB(255, 17, 44, 61),
        elevation: 12.sp,
      ),
    ): ElevatedButton(
              onPressed: () async {
                await WidgetRef.read(isLoggingIn.notifier)
                    .login(context: BuildContext);
                
                Navigator.of(BuildContext).pushNamed(RouteNames.homeView);
              },
              child: bool
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.sp,
                          width: 15.sp,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Please Wait...",
                          style: AppTheme().headText2.copyWith(
                            color: Colors.black,
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
                            child: Image.asset(ImagePaths.google_logo)),
                        Container(
                          width: 10.sp,
                        ),
                        Text(
                          "Log In",
                          style: AppTheme().headText2.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Color.fromARGB(255, 21, 63, 94),
                fixedSize: Size(140.sp, 50.sp),
                shadowColor: Color.fromARGB(255, 17, 44, 61),
                elevation: 15.sp,
              ),
            )
  );
}
