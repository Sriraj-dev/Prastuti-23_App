
import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();


  Future<dynamic> loginApi(String tokenId)async{

    Map<String,String> data = {
      "tokenId":tokenId
    };

    try{
      dynamic response = await  _apiServices.getPostApiResponse(AppEndPoints.loginUrl,data);
      return response;
    }catch(e){
      throw e;
    }
  }
}