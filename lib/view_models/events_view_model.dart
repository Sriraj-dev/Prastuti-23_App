import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:prastuti_23/view_models/registration_handler.dart';

import '../models/eventListModel.dart';
import '../repositories/events_repository.dart';

final eventsProvider =
    FutureProvider<EventListModel>((ref) => EventsRepository().getEventsApi());

EventsViewModel eventsViewModel =  EventsViewModel();
final eventViewController = Get.put(eventsViewModel);

class EventsViewModel extends GetxController{

  //RxMap<handler> _isRegistered = <String,handler>{}.obs;
  RxMap<String,handler> _isRegistered = <String,handler>{}.obs;

  handler getRegistrationStatus(String eventId) => _isRegistered[eventId]??handler.NOTREGISTERED;

  verifyRegistrationStatus(List<Events> events){
    List<String> registeredEventIds = [];
    currentUser.eventsParticipated!.forEach((element) {
      print("User is registered in - ${element.name!}");
      registeredEventIds.add(element.sId!);
    });
    print("Im Verifying events again!! - ${registeredEventIds.length}");
    events.forEach((element) {
      if (registeredEventIds.contains(element.sId)) {
        _isRegistered[element.sId!] = handler.REGISTERED;
      } else {
        _isRegistered[element.sId!] = handler.NOTREGISTERED;
      }
    });
  }

  changeRegistrationStatus(String eventId, handler status){
    _isRegistered[eventId] = status;
  }

}
