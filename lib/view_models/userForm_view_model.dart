import 'package:flutter/material.dart';
import 'package:prastuti_23/repositories/userForm_repository.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';

class RegistrationViewModel{

  Future<bool> submitRegistrationForm(String college,num phone,
  List<String> socialUrls,List<String> interests,String gender,
  String id,BuildContext context)async{

    Map<String,dynamic> data = {
      "College":college,
      "Phone" : phone,
      "SocialMedia_Links":socialUrls,
      "Gender":gender,
      "Interests":interests,
      "isFormFilled":true
    };

    bool isFormSubmitted =  await UserFormRepository().editUser(id, data);
    if(isFormSubmitted){
      Navigator.of(context).popAndPushNamed(RouteNames.homeView);
      return true;
    }else{
      Utils.flushBarMessage(
        message: "An Error Occurred!!Try Again!!",
        context: context,
        bgColor: Colors.redAccent
      );
      return false;
    }

  }

}