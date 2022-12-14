import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';

final isLoggingIn = StateNotifierProvider<LoginViewModelNotifier, bool>
  ((ref)=>LoginViewModelNotifier());

class LoginViewModelNotifier extends StateNotifier<bool>{

  LoginViewModelNotifier() : super (false);

  Future<void> login(
      {String username = "", String password = "", BuildContext? context})async{

    state = true;
    //TODO: Implement the Functionality of LOGIN - Sriraj
    await Future.delayed(const Duration(seconds: 3));
    state = false;

    //If the user is Successfully LoggedIn
    if(true){
      Utils.flushBarMessage(message: "Successfully Logged In",
      context: context,bgColor: Colors.green);
    }else{
      //Handle the case when the user is not logged In!
      //Basically show a FlushBar with the error
    }
  }


}

List<String> title =[
  "About Us",
  "Enthralling Events",
  "Exciting Rewards"
];

List<String> detail = [
  "Annual departmental fest of the department of Electrical Engineering, Prastuti provides curious minds a platform to lean, compete and develop their technical skills",
  "The 21st iteration brings a series of 6 intellectual and innovative events with workshops and fun challenging problem statements",
  "Tempeting Prizes to win through different competitions, Access to Guest Lectures by expert in the field, Excellent learning opportunities"
];

List<String> images = [
  "assets/login_view/sample_image_01.jpg",
  "assets/login_view/sample_image_02.png",
  "assets/login_view/sample_image_01.jpg",
];