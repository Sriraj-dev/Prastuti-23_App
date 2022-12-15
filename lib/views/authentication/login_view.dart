import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../animations/login_view_animation.dart';
import '../../config/login_view_content.dart';
import '../../config/screen_config.dart';
import '../../view_models/auth_view_model.dart';

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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 3),
          builder: ((context, double value, child) => Opacity(
                opacity: value,
                child: child,
              )),
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/login_view/prastuti'23_logo_1.png",
                  height: SizeConfig.height * 0.15,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: SizeConfig.heightPercent * 70,
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
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                left: (1.0 -
                                        animationController
                                            .pagePaddingValue.value) *
                                    100,
                              ),
                              child: Opacity(
                                opacity:
                                    animationController.pagePaddingValue.value,
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
                                  child: Image.asset(
                                    images[index],
                                    scale: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            top: (1.0 -
                                    animationController
                                        .pagePaddingValue.value) *
                                75,
                          ),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
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
                    ]),
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
                    dotHeight: 6.0,
                    dotWidth: 10,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.width * 0.43,
              ),
              Consumer(builder: (context, ref, child) {
                bool isLoading = ref.watch(isLoggingIn);
                return (SignInButton(_currentPage, ref, context, isLoading));
              })
            ],
          ),
        )
      ],
    ));
  }
}
//           Positioned(
//             right: MediaQuery.of(context).size.width*0.05,
//             bottom: MediaQuery.of(context).size.height*0.05,
//             height: MediaQuery.of(context).size.height*0.05,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
// // <<<<<<< Updated upstream
//                 AnimatedSmoothIndicator(
//                   activeIndex: _currentPage,
//                   count: 3,
//                   effect: WormEffect(
//                     activeDotColor: Color(0xff272727),
//                     dotHeight: 5.0
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.43,
//                 ),
//                 ElevatedButton(
//                   // OnPressed to be implemented
//                   onPressed: () {
//                     // TODO: Google Login to be implemented by Siraj bhaiya
// // =======
//                 Padding(
//                   padding: const EdgeInsets.only(left: 25),
//                   child: AnimatedSmoothIndicator(
//                     activeIndex: _currentPage,
//                     count: 3,
//                     effect: const WormEffect(
//                       activeDotColor: Color(0xff272727),
//                       dotHeight: 10.0,
//                       dotWidth: 10,
//                     ),
//                   ),
//                 ),
//                 Consumer(
//                   builder: (context,ref,child){
//                     bool isLoading = ref.watch(isLoggingIn);
//                     return (
//                         SignInButton(_currentPage, ref, context, isLoading)
//                     );
//                     //TODO: Loading Widget UI - Manash / Yash
// // >>>>>>> Stashed changes
//                   },
//                   child: Container(
//                     padding: EdgeInsets.only(right: 20),
//                     height: 50,
//                     child: Image.asset('assets/login_view/google.png'),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: StadiumBorder(),
//                     backgroundColor: Colors.transparent,
//                   ),
//                 )
//               ],
//             ),
//           )

// @override
// Widget build(BuildContext context) {
//
//   return SafeArea(
//     child: Scaffold(
//       body: Stack(
//         children: [
//           LiquidSwipe(
//             pages: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Color.fromARGB(26, 13, 27, 196),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Image.asset('assets/login_view/sample_image_01.jpg'),
//                     Column(
//                       children: [
//                         Text(
//                           'About Us',
//                           style: TextStyle(
//                             fontSize: 45,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 13, 27, 196),
//                             fontFamily: 'Roboto',
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(2.0, 2.0),
//                                 blurRadius: 3.0,
//                                 color: Color.fromARGB(129, 13, 27, 196),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(aboutUs),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Image.asset('assets/login_view/sample_image_02.png'),
//                     Column(
//                       children: [
//                         Text('Hi'),
//                         Text('Hi'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Image.asset('assets/login_view/sample_image_01.jpg'),
//                     Column(
//                       children: [
//                         Text('Hi'),
//                         Text('Hi'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Image.asset('assets/login_view/sample_image_02.png'),
//                     Column(
//                       children: [
//                         Text('Hi'),
//                         Text('Hi'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             onPageChangeCallback: onPageChangedCallBack,
//             slideIconWidget: const Icon(Icons.arrow_back_ios),
//             enableSideReveal: true,
//           ),
//           Positioned(
//               left: MediaQuery.of(context).size.width*0.2,
//               top: MediaQuery.of(context).size.height*0.025,
//               height: MediaQuery.of(context).size.height*0.08,
//               child: Container(
//                 width: MediaQuery.of(context).size.width*0.6,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/login_view/prastuti'23_logo_1.png"),
//                         fit: BoxFit.fitWidth
//                     )
//                 ),
//               )
//           ),
//           Positioned(
//             left: MediaQuery.of(context).size.width*0.05,
//             bottom: MediaQuery.of(context).size.height*0.03,
//             height: MediaQuery.of(context).size.height*0.1,
//             child: Container(
//               width: MediaQuery.of(context).size.width*0.9,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   AnimatedSmoothIndicator(
//                     activeIndex: controller.currentPage,
//                     count: 3,
//                     effect: WormEffect(
//                       activeDotColor: Color(0xff272727),
//                       dotHeight: 5.0
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.2,
//                   ),
//                   ElevatedButton(
//                     // OnPressed to be implemented
//                     onPressed: () {},
//                     child: Container(
//                       height: 50,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             'Google Login',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   )
//                 ],
//               ),
//             )
//           ),
//         ],
//       ),
//     ),
//   );
// }
