

import 'package:flutter/animation.dart';
import 'package:get/get.dart';



class LoginViewAnimation extends GetxController{

  RxDouble pagePaddingValue = 0.0.obs;
  late Animation<double> pageAnimation;
  late AnimationController pageAnimationController;

  initiatePageAnimation(obj){
    pageAnimationController = AnimationController(
      vsync: obj, duration: const Duration(milliseconds: 500),
    );
    pageAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: pageAnimationController,
          curve: Curves.decelerate
          )
        );
    pageAnimation.addListener(() {
      pagePaddingValue.value = pageAnimation.value;
    });

    pageAnimationController.forward();
  }

  restartPageAnimation(){
    pageAnimationController.reset();
    pageAnimationController.forward();
  }

  disposePageAnimation(){
    pageAnimationController.dispose();
  }

}