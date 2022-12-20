

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

EventsViewAnimation eventsViewAnimation = EventsViewAnimation();
final animationController = Get.put(eventsViewAnimation);

class EventsViewAnimation extends GetxController{
  RxDouble pagePaddingValue = 0.0.obs;
  late Animation<double> pageAnimation;
  late AnimationController pageAnimationController;

  initiatePageAnimation(obj) {
    pageAnimationController = AnimationController(
      vsync: obj,
      duration: const Duration(milliseconds: 500),
    );
    pageAnimation =
        Tween<double>(begin: 0, end: 1).animate(pageAnimationController);
    pageAnimation.addListener(() {
      print("THe value of animation is ${pageAnimation.value}");
      pagePaddingValue.value = pageAnimation.value;
    });

    pageAnimationController.forward();
  }

  restartPageAnimation() {
    pageAnimationController.reset();
    pageAnimationController.forward();
  }

  disposePageAnimation() {
    pageAnimationController.dispose();
  }

}