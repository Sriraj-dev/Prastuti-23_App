

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prastuti_23/models/teamsModel.dart';
import 'package:prastuti_23/repositories/profile_repository.dart';

final teamsProvider = FutureProvider.family<List<Teams>,List<String>>((ref,arg)async{
  print("loading userTeams");
  List<Teams> userTeams = [];
  // arg.forEach((id) async {
  //   userTeams.add(await ProfileRepository().getTeamFromId(id));
  // });

  print("User teams retuerned");

  return userTeams;
});

