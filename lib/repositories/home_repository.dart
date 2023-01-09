

import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future getEventsApi()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppEndPoints.eventsUrl);
      //eventsListModel need to be created 
      //this json response need to be converted into EventsListModel.
      return response;

    }catch(e){
      throw e;
    }
  }
}