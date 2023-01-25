

import 'package:flutter/cupertino.dart';
import 'package:prastuti_23/repositories/registration_repository.dart';
import 'package:prastuti_23/view_models/events_view_model.dart';

enum handler { NOTREGISTERED, LOADING, REGISTERED }

class RegistrationHandler{

  Future<bool> registerInSoloEvent({required String userId,
      required String eventId,
      required BuildContext context})async{

    Map<String,dynamic> data = {
      "user_id" : userId,
      "event_id": eventId
    };

    return await RegistrationRepository().sendSoloRegistrationRequest(data, context);
  }

  Future<bool> registereInTeamEvent({required String userId,required  String eventId,
      required String teamId,
      required int eventIndex,
      required BuildContext context})async{
    Map<String,dynamic> data = {
      "user_id" : userId,
      "event_id": eventId,
      "team_id":teamId
    };

    bool isRegistered = await RegistrationRepository().sendTeamRegistrationRequest(data, context);
    if(isRegistered){
      eventViewController.changeRegistrationStatus(eventIndex, handler.REGISTERED);
      return true;
    }else{
      return false;
    }
  }
}