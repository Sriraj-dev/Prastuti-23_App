import 'dart:convert';
import 'package:http/http.dart';
import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/UserModel.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();


  Future<UserModel> loginApi(String tokenId)async{

    Map<String,String> data = {
      "tokenId":tokenId
    };

    dynamic response =
        await _apiServices.getPostApiResponse(AppEndPoints.loginUrl, data);

    if(response.statusCode == 200){
      return response = UserModel.fromJson(json.decode(response.body));
    }else return UserModel();
  }
}