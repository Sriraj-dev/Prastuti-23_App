import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/animations/login_view_animation.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    loginAnimation.initiateLogoAnimation(this);
    loginAnimation.initiatePageAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(()=>Opacity(
            opacity: animationController.logoOpacityValue.value,
            child: Container(
                child: Image.asset(
                  "assets/login_view/prastuti'23_logo_1.png",
                  height: SizeConfig.height * 0.2,
                ),
              ),
            )
          ),
          
          Container(
            height: SizeConfig.heightPercent*60,
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (int page) {
                loginAnimation.restartPageAnimation();
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.width*0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            ()=> Padding(
                              padding:  EdgeInsets.only(
                                left: (1.0-animationController.pagePaddingValue.value)*100,
                              ),
                              child: Opacity(
                                opacity: animationController.pagePaddingValue.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(images[index],scale: 1.2,),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Obx(
                        ()=> Padding(
                          padding:  EdgeInsets.only(
                                top: (1.0-animationController.pagePaddingValue.value)*75,),
                          child: Opacity(
                            opacity: animationController.pagePaddingValue.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: "Roboto",
                                    fontSize: 40,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: Text(
                                    detail[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: "Roboto",
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                );
              },
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
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: Color(0xff272727),
                      dotHeight: 3.0,
                      dotWidth: 5,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.width*0.43,
                ),
                Consumer(
                  builder: (context,ref,child){
                    bool isLoading = ref.watch(isLoggingIn);
                    return (isLoading)?
                    //TODO: Loading Widget UI - Manash / Yash
                    CircularProgressIndicator():
                    ElevatedButton(
                    onPressed: () {
                      ref.read(isLoggingIn.notifier).login(context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      height: 40,
                      child: Image.asset('assets/login_view/google.png'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.transparent,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}


