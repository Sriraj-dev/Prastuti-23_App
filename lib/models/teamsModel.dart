import 'package:prastuti_23/models/UserModel.dart';

class TeamModel {
  Teams? team;

  TeamModel({this.team});

  TeamModel.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ?  Teams.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    return data;
  }
}


class Teams {
  String? sId;
  String? teamName;
  List<String>? eventsParticipated;
  List<Members>? members;
  int? memberCount;
  List<String>? pendingRequests;
  String? slug;

  Teams(
      {this.sId,
      this.teamName,
      this.eventsParticipated,
      this.members,
      this.memberCount,
      this.pendingRequests,
      this.slug});

  Teams.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teamName = json['Team_Name'];
    eventsParticipated = json['Events_Participated'].cast<String>();
    if (json['Members'] != null) {
      members = <Members>[];
      json['Members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    memberCount = json['Member_Count'];
    pendingRequests = json['Pending_Requests'].cast<String>();
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['Team_Name'] = this.teamName;
    data['Events_Participated'] = this.eventsParticipated;
    if (this.members != null) {
      data['Members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['Member_Count'] = this.memberCount;
    data['Pending_Requests'] = this.pendingRequests;
    data['slug'] = this.slug;
    return data;
  }
}
