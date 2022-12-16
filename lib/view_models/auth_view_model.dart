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

Widget SignInButton(int, WidgetRef, BuildContext, bool) {
  if (int < 2) {
    return ElevatedButton(
      onPressed: () {
        null;
      },
      child: Image.asset('assets/login_view/google.png'),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        fixedSize: Size(60, 60),
        shadowColor: Colors.grey,
        elevation: 15,
      ),
    );
  } else {
    return ElevatedButton(
      onPressed: () {
        WidgetRef.read(isLoggingIn.notifier).login(context: BuildContext);
      },
      child: bool
          ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
              ),
              Text(
                "Please Wait...",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 35,
                    width: 35,
                    child: Image.asset('assets/login_view/google.png')),
                Container(
                  width: 10,
                ),
                Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.black,
        fixedSize: Size(143, 50),
        shadowColor: Colors.grey,
        elevation: 15,
      ),
    );
  }
}
