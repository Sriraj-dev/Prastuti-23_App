import 'package:flutter/cupertino.dart';
import 'package:prastuti_23/models/eventListModel.dart';
import 'package:prastuti_23/repositories/profile_repository.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';

List<String> joinedAs = [];
List<String> scoreInEvent = [];
List<String> startDate = [];

class ProfileViewModel{
  
void buildRegisteredEventsDetails(List<Events> regEvents) {
    for (int index = 0; index < regEvents.length; index++) {
      //user id if its a solo event ,
      //team id if its a team event.
      print(regEvents[index].sId! +" : "+ regEvents[index].teamEvent!.toString());
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

  createTeam({required String teamName,
      required  String userId,
      required  BuildContext context}) async {
    Map<String, dynamic> data = {
      "userID": userId,
      "Team_Name": teamName,
      "Member_Count": 1
    };

    
    return await ProfileRepository().placeCreateTeamRequest(data, context);
  }

  sendTeamRequest({required String email,
      required String userId,
      required String teamId,
      required BuildContext context})async{
    Map<String,dynamic> data = {
      "recepient_email": email,
      "team_id":teamId,
      "user_id":userId
    };

    return await ProfileRepository().placeInvitationToUser(data, context);
  }

  acceptRequest(String requestId,BuildContext context)async{

    Map<String ,dynamic> data = {
      "requestId" : requestId,
    };

    return await ProfileRepository().acceptInvitation(data, context);

  }

  rejectRequest(String requestId, BuildContext context) async {
    Map<String, dynamic> data = {
      "requestId": requestId,
    };

    return await ProfileRepository().rejectInvitation(data, context);
  }
}