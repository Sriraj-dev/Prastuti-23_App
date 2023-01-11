

import 'dart:convert';

import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/teamsModel.dart';

class ProfileRepository{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<Team> getTeamFromId(String id)async{

    dynamic response = await _apiServices.getGetApiResponse(AppEndPoints().getTeamUrl(id));

    return response = TeamModel.fromJson(json.decode(response.body)).team!;

  }
}