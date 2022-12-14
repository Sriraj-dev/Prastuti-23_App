import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:prastuti_23/view_models/login_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModelNotifier loginViewModel = LoginViewModelNotifier();

  //TODO: UI of the Login Screen (Google Auth Most Probably) - Manash/Yash
  //TODO: Floating Action Button is just for your reference
  // You can customise the Buttons(UI) as per your design
  //I will implement the OnTap/OnPressed Functions if u r not getting it..

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width*0.2,
            top: MediaQuery.of(context).size.height*0.025,
            height: MediaQuery.of(context).size.height*0.08,
            child: Container(
              width: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/login_view/prastuti'23_logo_1.png"),
                      fit: BoxFit.fitWidth
                  )
              ),
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.12, 0, MediaQuery.of(context).size.height*0.10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                ),
                FractionallySizedBox(
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 250),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover,
                                ),
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
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height*0.03,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontFamily: "Roboto",
                                      fontSize: 40,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.15,
                                    width: MediaQuery.of(context).size.width*0.80,
                                    child: Text(
                                      detail[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: "Roboto",
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              )
                            )
                          ]
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width*0.05,
            bottom: MediaQuery.of(context).size.height*0.05,
            height: MediaQuery.of(context).size.height*0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: _currentPage,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: Color(0xff272727),
                    dotHeight: 5.0
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.43,
                ),
                ElevatedButton(
                  // OnPressed to be implemented
                  onPressed: () {
                    // TODO: Google Login to be implemented by Siraj bhaiya
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    height: 50,
                    child: Image.asset('assets/login_view/google.png'),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

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
}


