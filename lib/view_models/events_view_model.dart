import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/eventListModel.dart';
import '../repositories/events_repository.dart';

final eventsProvider =
    FutureProvider<EventListModel>((ref) => EventsRepository().getEventsApi());
