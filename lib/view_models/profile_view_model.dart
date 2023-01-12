import 'package:prastuti_23/models/eventListModel.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

List<String> joinedAs = [];
List<String> scoreInEvent = [];
List<String> startDate = [];

void buildRegisteredEventsDetails(List<Events> regEvents) {
  for (int index = 0; index < regEvents.length; index++) {
    //user id if its a solo event ,
    //team id if its a team event.

    String id = currentUser.sId!;
    String subTitle = "Solo Event";
    String score = "";
    if (regEvents[index].teamEvent!) {
      //for getting the team with which the user joined.
      final jTeam = (currentUser.teams!.firstWhere((element) =>
          element.eventsParticipated!.contains(regEvents[index].sId)));
      id = jTeam.sId!;
      subTitle = jTeam.teamName!;

      //for getting the score of the team from eventModel.
      score = regEvents[index]
          .teams!
          .firstWhere(((element) => element.team == jTeam.sId))
          .score
          .toString();
    } else {
      //calculating the score of User if its a solo event
      score = regEvents[index]
          .participants!
          .firstWhere((element) => element.participant == currentUser.sId)
          .score
          .toString();
    }
    //getting the start date of the event.
    String date = "coming soon!";
    if (regEvents[index].timeline != null) {
      date = regEvents[index].timeline![0].date!;
    }
    joinedAs.add(subTitle);
    scoreInEvent.add(score);
    startDate.add(date);
  }
}
