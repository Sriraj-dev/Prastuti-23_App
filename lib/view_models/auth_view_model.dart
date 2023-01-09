import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/repositories/auth_repository.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/notification_view_model.dart';

final isLoggingIn = StateNotifierProvider<AuthViewModelNotifier, bool>
  ((ref)=>AuthViewModelNotifier());


class AuthViewModelNotifier extends StateNotifier<bool>{

  AuthViewModelNotifier() : super (false);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
   clientId: Env.webClientId,
    scopes: [
      'email',
    ],
  );

  Future<void> login({required BuildContext context})async{

    state = true;
    //NotificationServices().getPlayerId();

    try {
      final result =  await _googleSignIn.signIn();
      if(result==null){state =false; return ;}
      
      result.authentication.then((googleKey)async{
        log(googleKey.idToken!);

        //Apne backend server pe login kro.
        //AuthRepository().loginApi(googleKey.idToken!);
      });

      Utils.flushBarMessage(
      message: "Successfully Logged In",
      context: context,
      bgColor: Colors.green);

      Navigator.of(context).pushNamed(RouteNames.homeView);
      state = false;

    } catch (error) {
      Utils.flushBarMessage(
          message: "Failed to Login!!", context: context, bgColor: Colors.red);
      
      state = false;
    }
  }

  Future<void> logout({BuildContext? context})async{

    state = true;
    await _googleSignIn.disconnect();

    state = false;
    Navigator.of(context!).pop();
    Navigator.of(context).pushNamed(RouteNames.loginView);
    
  }

}