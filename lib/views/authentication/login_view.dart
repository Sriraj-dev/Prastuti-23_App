import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prastuti_23/view_models/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModelNotifier loginViewModel = LoginViewModelNotifier();

  //TODO: UI of the Login Screen (Google Auth Most Probably) - Manash/Yash
  //TODO: Floating Action Button is just for your reference
  // You can customise the Buttons(UI) as per your design
  //I will implement the OnTap/OnPressed Functions if u r not getting it..

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text("This is the Login Screen"),
        ),
      ),

      //TODO: Just an Example to understand the flow
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          bool isLoading = ref.watch(isLoggingIn);
          return FloatingActionButton(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : const Center(
                    child: Text("Login"),
                  ),
            onPressed: () {
              ref.read(isLoggingIn.notifier)
                  .login(username: "", password: "", context: context);
            },
          );
        },
      ),
    );
  }
}
