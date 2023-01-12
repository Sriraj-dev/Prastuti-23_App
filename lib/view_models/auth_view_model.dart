import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prastuti_23/config/env.dart';

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

      if(currentUser.appId == null || currentUser.appId ==" " || currentUser.appId!.isEmpty){
        //create SharedPreferences and store the playerId in local Storage.
        //if registration form is filles then edit the User with that player_id.
        //if registration form is not filled then edit the playerid while submitting registration form.
        NotificationServices().getPlayerId();

        //edit User by giving AppId;
      }

      
      Utils.flushBarMessage(
      message: "Successfully Logged In",
      context: context,
      bgColor: Colors.green);

      if(currentUser.isFormFilled!){
        Navigator.of(context).pushNamed(RouteNames.homeView);
      }else{
        Navigator.of(context).pushNamed(RouteNames.registrationForm);
      }
      
      state = false;
    } catch (error) {
      print(error);
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