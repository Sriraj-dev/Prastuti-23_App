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