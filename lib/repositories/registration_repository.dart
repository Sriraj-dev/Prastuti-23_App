

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

class RegistrationRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<bool> sendSoloRegistrationRequest(Map<String,dynamic> data,BuildContext context)async{
    dynamic response = await _apiServices.getPostApiResponse(AppEndPoints.soloRegistrationUrl,data);

    final res = json.decode(response.body);

    Utils.flushBarMessage(
      context: context,
      bgColor: Colors.green,
      message: res["message"].toString()
    );
    if(response.statusCode == 200|| response.statusCode == 201){
      currentUser = User.fromJson(res["updatedUser"]);
      return true;
    }else{
      return false;
    }
  }

  
  Future<bool> sendTeamRegistrationRequest(Map<String, dynamic> data,BuildContext context) async {
    dynamic response = await _apiServices.getPostApiResponse(AppEndPoints.teamRegistrationUrl, data);

    final res = json.decode(response.body);

        
    if(response.statusCode == 200 || response.statusCode == 201){
      currentUser = User.fromJson(res["updatedUser"]);
      return true;
    }else{
          Utils.flushBarMessage(
          context: context, bgColor: Colors.red, message: res['message']);
      return false;
    }
  }
}
