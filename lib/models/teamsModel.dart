class TeamModel {
  Team? team;

  TeamModel({this.team});

  TeamModel.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    return data;
  }
}

class Team {
  String? sId;
  String? teamName;
  List<dynamic>? eventsParticipated;
  List<Members>? members;
  int? memberCount;
  List<String>? pendingRequests;
  String? slug;
  int? iV;

  Team(
      {this.sId,
      this.teamName,
      this.eventsParticipated,
      this.members,
      this.memberCount,
      this.pendingRequests,
      this.slug,
      this.iV});

  Team.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    teamName = json['Team_Name'];
    if (json['Events_Participated'] != null) {
      eventsParticipated = <dynamic>[];
      json['Events_Participated'].forEach((v) {
        eventsParticipated!.add(v);
      });
    }
    if (json['Members'] != null) {
      members = <Members>[];
      json['Members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    memberCount = json['Member_Count'];
    if (json['Pending_Requests'] != null) {
      pendingRequests = <String>[];
      json['Pending_Requests'].forEach((v) {
        pendingRequests!.add(v);
      });
    }
    slug = json['slug'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Team_Name'] = this.teamName;
    if (this.eventsParticipated != null) {
      data['Events_Participated'] =
          this.eventsParticipated!.map((v) => v.toJson()).toList();
    }
    if (this.members != null) {
      data['Members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['Member_Count'] = this.memberCount;
    if (this.pendingRequests != null) {
      data['Pending_Requests'] =
          this.pendingRequests!.map((v) => v.toString()).toList();
    }
    data['slug'] = this.slug;
    data['__v'] = this.iV;
    return data;
  }
}

class Members {
  List<String>? interests;
  List<String>? socialMediaLinks;
  String? sId;
  String? name;
  String? emailId;
  String? college;
  String? profilePhoto;

  Members(
      {this.interests,
      this.socialMediaLinks,
      this.sId,
      this.name,
      this.emailId,
      this.college,
      this.profilePhoto});

  Members.fromJson(Map<String, dynamic> json) {
    if (json['Interests'] != null) {
      interests = <String>[];
      json['Interests'].forEach((v) {
        interests!.add(v);
      });
    }
    if (json['SocialMedia_Links'] != null) {
      socialMediaLinks = <String>[];
      json['SocialMedia_Links'].forEach((v) {
        socialMediaLinks!.add(v);
      });
    }
    sId = json['_id'];
    name = json['Name'];
    emailId = json['email_id'];
    college = json['College'];
    profilePhoto = json['Profile_Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interests != null) {
      data['Interests'] = this.interests!.map((v) => v.toString()).toList();
    }
    if (this.socialMediaLinks != null) {
      data['SocialMedia_Links'] =
          this.socialMediaLinks!.map((v) => v.toString()).toList();
    }
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['email_id'] = this.emailId;
    data['College'] = this.college;
    data['Profile_Photo'] = this.profilePhoto;
    return data;
  }
}
