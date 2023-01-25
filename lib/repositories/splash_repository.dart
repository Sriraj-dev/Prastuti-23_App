

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  deleteToken() async {
    await storage.delete(key: "token");
  }

  getToken() async {
    try {
      return await storage.read(key: "token");
    } catch (e) {
      return null;
    }
  }
}

class SplashRepository{
  BaseApiServices _apiServices = NetworkApiServices();

   Future<bool> loginUsingUserId(String userId)async{
    dynamic response =await  _apiServices.getGetApiResponse(AppEndPoints().getUser(userId));

    if(response.statusCode == 200){
      log(response.body);
      currentUser = User.fromJson(json.decode(response.body)[0]);
      return true;
    }else{
      return false;
    }
   }
}
