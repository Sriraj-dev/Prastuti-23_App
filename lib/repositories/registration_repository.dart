
import 'dart:convert';

import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/UserModel.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

class RegistrationRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<bool> editUser(String id,Map<String,dynamic> data)async{

    try{
      dynamic response = await _apiServices.getPutApiResponse(AppEndPoints().editUser(id),data);

      
      if(response.statusCode == 200){
        currentUser = User.fromJson(json.decode(response.body));
        return true;
      }else return false;
    }catch(e){
      return false;
    }

  }
}