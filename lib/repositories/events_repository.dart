import 'dart:convert';

import 'package:prastuti_23/config/app_endpoints.dart';
import 'package:prastuti_23/data/app_exceptions.dart';
import 'package:prastuti_23/data/network/base_api_services.dart';
import 'package:prastuti_23/data/network/network_api_services.dart';
import 'package:prastuti_23/models/eventListModel.dart';

class EventsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<EventListModel> getEventsApi() async {
     dynamic response =
        await _apiServices.getGetApiResponse(AppEndPoints.eventsUrl);
    return EventListModel.fromJson(json.decode(response.body));
  }
}
