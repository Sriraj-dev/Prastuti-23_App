import 'package:prastuti_23/models/eventListModel.dart';
import 'package:prastuti_23/models/teamsModel.dart';

class UserModel {
  String? message;
  User? user;
  bool? isNew;

  UserModel({this.message, this.user, this.isNew});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['isNew'] = this.isNew;
    return data;
  }
}


class User {
  String? sId;
  String? name;
  String? emailId;
  String? profilePhoto;
  List<String>? interests;
  List<String>? socialMediaLinks;
  String? appId;
  bool? isFormFilled;
  List<Teams>? teams;
  List<PendingRequests>? pendingRequests;
  int? totalScore;
  List<Events>? eventsParticipated;
  int? iV;
  String? college;
  String? gender;
  int? phone;

  User(
      {this.sId,
      this.name,
      this.emailId,
      this.profilePhoto,
      this.interests,
      this.socialMediaLinks,
      this.appId,
      this.isFormFilled,
      this.teams,
      this.pendingRequests,
      this.totalScore,
      this.eventsParticipated,
      this.iV,
      this.college,
      this.gender,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    emailId = json['email_id'];
    profilePhoto = json['Profile_Photo'];
    if (json['Interests'] != null) {
      interests = <String>[];
      json['Interests'].forEach((v) {
        interests!.add(v.toString());
      });
    }
    if (json['SocialMedia_Links'] != null) {
      socialMediaLinks = <String>[];
      json['SocialMedia_Links'].forEach((v) {
        socialMediaLinks!.add(v.toString());
      });
    }

    appId = json['App_id'];
    isFormFilled = json['isFormFilled'];
    if (json['Teams'] != null) {
      teams = <Teams>[];
      json['Teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    if (json['Pending_Requests'] != null) {
      pendingRequests = <PendingRequests>[];
      json['Pending_Requests'].forEach((v) {
        pendingRequests!.add(PendingRequests.fromJson(v));
      });
    }
    totalScore = json['Total_Score'];
    if (json['Events_Participated'] != null) {
      eventsParticipated = <Events>[];
      json['Events_Participated'].forEach((v) {
        eventsParticipated!.add(Events.fromJson(v));
      });
    }
    iV = json['__v'];
    college = json['College'];
    gender = json['Gender'];
    phone = json['Phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['email_id'] = this.emailId;
    data['Profile_Photo'] = this.profilePhoto;
    data['Interests'] = this.interests;
    data['SocialMedia_Links'] = this.socialMediaLinks;
    data['App_id'] = this.appId;
    data['isFormFilled'] = this.isFormFilled;
    if (this.teams != null) {
      data['Teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    if (this.pendingRequests != null) {
      data['Pending_Requests'] =
          this.pendingRequests!.map((v) => v.toJson()).toList();
    }
    data['Total_Score'] = this.totalScore;
    if (this.eventsParticipated != null) {
      data['Events_Participated'] =
          this.eventsParticipated!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['College'] = this.college;
    data['Gender'] = this.gender;
    data['Phone'] = this.phone;
    return data;
  }
}

class Members {
  String? sId;
  String? name;
  String? emailId;
  String? profilePhoto;
  List<String>? interests;
  List<String>? socialMediaLinks;
  String? appId;
  bool? isFormFilled;
  String? college;
  String? gender;

  Members(
      {this.sId,
      this.name,
      this.emailId,
      this.profilePhoto,
      this.interests,
      this.socialMediaLinks,
      this.appId,
      this.isFormFilled,
      this.college,
      this.gender});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    emailId = json['email_id'];
    profilePhoto = json['Profile_Photo'];
    interests = json['Interests'].cast<String>();
    socialMediaLinks = json['SocialMedia_Links'].cast<String>();
    appId = json['App_id'];
    isFormFilled = json['isFormFilled'];
    college = json['College'];
    gender = json['Gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['email_id'] = this.emailId;
    data['Profile_Photo'] = this.profilePhoto;
    data['Interests'] = this.interests;
    data['SocialMedia_Links'] = this.socialMediaLinks;
    data['App_id'] = this.appId;
    data['isFormFilled'] = this.isFormFilled;
    data['College'] = this.college;
    data['Gender'] = this.gender;
    return data;
  }
}

class PendingRequests {
  String? sId;
  String? teamName;
  String? team;
  String? requestedTo;
  String? requestedFrom;

  PendingRequests({this.sId, this.teamName,this.team, this.requestedTo, this.requestedFrom});

  PendingRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teamName = json['teamName'];
    team = json['team'];
    requestedTo = json['requested_to'];
    requestedFrom = json['requested_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['teamName'] = this.teamName;
    data['team'] = this.team;
    data['requested_to'] = this.requestedTo;
    data['requested_from'] = this.requestedFrom;
    return data;
  }
}
