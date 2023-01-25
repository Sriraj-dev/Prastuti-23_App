import 'dart:convert';
import 'dart:io';
import 'package:prastuti_23/data/app_exceptions.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices extends BaseApiServices{

  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson;
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
        "Content-Type": "application/json"
        }
      ).timeout(const Duration(seconds: 10)).catchError((e){
        return "error";
      });
      responseJson = checkResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url,Map<String,dynamic> data) async {
    dynamic responseJson;
    try{
      final response = await http.post(
          Uri.parse(url),
        body: json.encode(data),
        headers: {
            "Content-Type": "application/json"
          }
      ).timeout(const Duration(seconds: 20));
      responseJson = checkResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }catch(e){
      throw e;
    }

    return responseJson;
  }

  @override
  Future getPutApiResponse(String url,Map<String,dynamic> data)async {
    dynamic responseJson;
    try{
      final response = await http.put(
          Uri.parse(url),
        body: json.encode(data),
        headers: {
            "Content-Type": "application/json"
          }
      ).timeout(const Duration(seconds: 20));
      responseJson = checkResponse(response);
      
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }catch(e){
      throw e;
    }
    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url,Map<String,dynamic> data) async{
    dynamic responseJson;
    try{
      final response = await http.delete(
          Uri.parse(url),
        body: json.encode(data),
        headers: {
            "Content-Type": "application/json"
          }
      ).timeout(const Duration(seconds: 20));
      responseJson = checkResponse(response);
      
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }catch(e){
      throw e;
    }
    return responseJson;
  }


  dynamic checkResponse(http.Response response){

    switch(response.statusCode){
      case 201:
      case 200:
        return response;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        return response;

      default:
        throw FetchDataException("Error Occurred while communicating with server!");
    }
  }

}