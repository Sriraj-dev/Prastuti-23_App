

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prastuti_23/models/teamsModel.dart';
import 'package:prastuti_23/repositories/profile_repository.dart';

final teamsProvider = FutureProvider.family<List<Team>,List<String>>((ref,arg)async{
  List<Team> userTeams = [];
  arg.forEach((id) async {
    userTeams.add(await ProfileRepository().getTeamFromId(id));
  });

  return userTeams;
});

//Will be implemented later:

// final requestsProvider =
//     FutureProvider.family<List<Team>, List<String>>((ref, arg) async {
//   List<Team> userTeams = [];
//   arg.forEach((id) async {
//     userTeams.add(await ProfileRepository().getTeamFromId(id));
//   });

//   return userTeams;
// });
