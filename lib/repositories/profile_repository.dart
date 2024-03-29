import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/models/teamsModel.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<Teams> getTeamFromId(String id) async {
    dynamic response =
        await _apiServices.getGetApiResponse(AppEndPoints().getTeamUrl(id));

    return response = TeamModel.fromJson(json.decode(response.body)).team!;
  }

  Future<bool> getUser(String id)async{
    dynamic response =
        await _apiServices.getGetApiResponse(AppEndPoints().getUser(id));

    if (response.statusCode == 200) {
      currentUser = User.fromJson(json.decode(response.body)[0]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> placeCreateTeamRequest(
      Map<String, dynamic> data, BuildContext context) async {
    dynamic response =
        await _apiServices.getPostApiResponse(AppEndPoints.createTeamUrl, data);

    final res = json.decode(response.body);
   Utils.flushBarMessage(
        context: context,
        bgColor: (response.statusCode == 200) ? Colors.green : Colors.redAccent,
        message: res['message']);

    if (response.statusCode == 200) {
      currentUser = User.fromJson(res["data"]["updatedUser"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> placeInvitationToUser(
      Map<String, dynamic> data, BuildContext context) async {
    dynamic response =
        await _apiServices.getPostApiResponse(AppEndPoints.sendRequest, data);

    final res = json.decode(response.body);
    Utils.flushBarMessage(
        context: context,
        bgColor: (response.statusCode == 200) ? Colors.green : Colors.redAccent,
        message: res['message']);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> acceptInvitation(
      Map<String, dynamic> data, BuildContext context) async {
    dynamic response =
        await _apiServices.getPostApiResponse(AppEndPoints.acceptRequest, data);

    final res = json.decode(response.body);
    Utils.flushBarMessage(
        context: context,
        bgColor: (response.statusCode == 200) ? Colors.green : Colors.redAccent,
        message: res['message']);

    //update the currentUser.

    if (response.statusCode == 200) {
      currentUser = User.fromJson(res["updatedUser"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> rejectInvitation(
      Map<String, dynamic> data, BuildContext context) async {
    dynamic response = await _apiServices.getDeleteApiResponse(
        AppEndPoints.deleteRequest, data);

    final res = json.decode(response.body);
    Utils.flushBarMessage(
        context: context, bgColor:(response.statusCode == 200)? Colors.green:Colors.redAccent,
         message: res['message']);

    //update the currentUser.

    if (response.statusCode == 200) {
      currentUser = User.fromJson(res["updatedUser"]);
      return true;
    } else {
      return false;
    }
  }
}
