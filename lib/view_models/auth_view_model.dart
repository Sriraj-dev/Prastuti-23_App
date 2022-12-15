import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';

final isLoggingIn = StateNotifierProvider<AuthViewModelNotifier, bool>
  ((ref)=>AuthViewModelNotifier());

final isLoggingOut = StateNotifierProvider<AuthViewModelNotifier, bool>(
    (ref) => AuthViewModelNotifier());

class AuthViewModelNotifier extends StateNotifier<bool>{

  AuthViewModelNotifier() : super (false);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> login({BuildContext? context})async{

    state = true;
    // ignore: todo
    //TODO: Implement the Functionality of LOGIN - Sriraj
    //await Future.delayed(const Duration(seconds: 3));

    try {
     final result =  await _googleSignIn.signIn();

     print("Google SignIn Headers _---_> ${result!.authHeaders}");
     
     result.authentication.then((googleKey){
      //TODO: Need to register the user from our backend.
      print("The TOkens are -> ${googleKey.accessToken} , ${googleKey.idToken}");
     });

      //If the user is Successfully LoggedIn
      if (result != null) {
        Utils.flushBarMessage(
            message: "Successfully Logged In",
            context: context,
            bgColor: Colors.green);
      } else {
        //Handle the case when the user is not logged In!
        //Basically show a FlushBar with the error

        Utils.flushBarMessage(
            message: "Failed to Login!!",
            context: context,
            bgColor: Colors.red);
      }

    } catch (error) {
      print(error);
    }

    state = false;
  }

  Future<void> logout({BuildContext? context})async{

    state = true;
    await _googleSignIn.disconnect();

    Navigator.of(context!).pop();
    Navigator.of(context).pushNamed(RouteNames.loginView);
    state = false;
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