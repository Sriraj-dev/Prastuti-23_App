import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prastuti_23/config/env.dart';
import 'package:prastuti_23/repositories/splash_repository.dart';
import 'package:restart_app/restart_app.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/repositories/auth_repository.dart';

import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/notification_view_model.dart';

final isLoggingIn = StateNotifierProvider<AuthViewModelNotifier, bool>
  ((ref)=>AuthViewModelNotifier());


late User currentUser;


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
    try {
      final result =  await _googleSignIn.signIn();
      if(result==null){state =false; return ;}
      
      String tokenId = "";
      await result.authentication.then((googleKey)async{
        log(googleKey.idToken!);
        tokenId = googleKey.idToken!;
      });

    UserModel currentUserModel =
          (await AuthRepository().loginApi(tokenId));

      if (currentUserModel.user == null) {
        await _googleSignIn.disconnect();
        Utils.flushBarMessage(
          message: "Error in communicating with server,Try Again!!",
          context: context,
          bgColor: Colors.red);
        state = false;
        return;
      }

      currentUser = currentUserModel.user!;

      
      navigateToRequiredScreen(context);
      SecureStorage().saveToken(currentUser.sId!);
      
      state = false;
    } catch (error) {
      print(error);
      Utils.flushBarMessage(
          message: "Failed to Login,Try Again!!", context: context, bgColor: Colors.red);
      
      state = false;
    }
  }

  navigateToRequiredScreen(BuildContext context)async{
    if(currentUser.appId == null || currentUser.appId ==" " || currentUser.appId!.isEmpty){
      String playerId = await NotificationServices().getPlayerId();

      AuthRepository().updatePlayerId(playerId);
    }else{
      AuthRepository().checkSubscription();
    }


    if (currentUser.isFormFilled!) {
      Navigator.of(context).popAndPushNamed(RouteNames.homeView);
      Utils.flushBarMessage(
          message: "Successfully Logged In",
          context: context,
          bgColor: Colors.green);
    } else {
      Navigator.of(context).pushNamed(RouteNames.registrationForm);
    }
  }

  Future<void> logout({BuildContext? context})async{

    state = true;
    
    if(_googleSignIn.currentUser != null){
      await _googleSignIn.disconnect();
    }
    currentUser = User.fromJson({});
    
    //Restart.restartApp(webOrigin: RouteNames.loginView);

    state = false;
    Navigator.of(context!).pop();
    Navigator.of(context).pushNamed(RouteNames.loginView);
  }

}