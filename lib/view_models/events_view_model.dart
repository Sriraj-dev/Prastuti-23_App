import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:prastuti_23/view_models/registration_handler.dart';

import '../models/eventListModel.dart';
import '../repositories/events_repository.dart';

final eventsProvider =
    FutureProvider<EventListModel>((ref) => EventsRepository().getEventsApi());

EventsViewModel eventsViewModel =  EventsViewModel();
final eventViewController = Get.put(eventsViewModel);

class EventsViewModel extends GetxController{

  RxList<handler> _isRegistered = <handler>[].obs;

  handler getRegistrationStatus(int index) => _isRegistered[index];

  initiateRegistrationStatus(List<Events> events,List<String> registeredEventIds){
    events.forEach((element) {
      if (registeredEventIds.contains(element.sId)) {
        _isRegistered.add(handler.REGISTERED);
      } else {
        _isRegistered.add(handler.NOTREGISTERED);
      }
    });
  }

  changeRegistrationStatus(int index, handler status){
    _isRegistered[index] = status;
  }

}
