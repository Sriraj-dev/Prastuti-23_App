

import 'package:flutter/animation.dart';
import 'package:get/get.dart';



class LoginViewAnimation extends GetxController{

  RxDouble logoOpacityValue = 0.0.obs;
  late Animation<double> logoAnimation;
  late AnimationController logoAnimationController;

  initiateLogoAnimation(obj){
    logoAnimationController = AnimationController(
        vsync: obj, duration: const Duration(milliseconds: 3000));
    logoAnimation = Tween<double>(begin: 0, end: 1).animate(logoAnimationController);
    logoAnimation.addListener(() {
      print("Animation Value os ${logoAnimation.value}");
      logoOpacityValue.value = logoAnimation.value;
    });

    logoAnimationController.forward();
  }

  disposeLogoAnimation(){
    logoAnimationController.dispose();
  }

  RxDouble pagePaddingValue = 0.0.obs;
  late Animation<double> pageAnimation;
  late AnimationController pageAnimationController;

  initiatePageAnimation(obj){
    pageAnimationController = AnimationController(
        vsync: obj, duration: const Duration(milliseconds: 1000));
    pageAnimation =
        Tween<double>(begin: 0, end: 1).animate(pageAnimationController);
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