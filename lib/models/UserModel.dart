// class UserModel {
//   String? message;
//   User? user;
//   bool? isNew;

//   UserModel({this.message, this.user, this.isNew});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     isNew = json['isNew'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['isNew'] = this.isNew;
//     return data;
//   }
// }

// class User {
//   String? name;
//   String? emailId;
//   String? profilePhoto;
//   List<String>? interests;
//   List<String>? socialMediaLinks;
//   String? appId;
//   List<dynamic>? teams;
//   List<dynamic>? pendingRequests;
//   int? totalScore;
//   List<dynamic>? eventsParticipated;
//   String? sId;
//   int? iV;

//   User(
//       {this.name,
//       this.emailId,
//       this.profilePhoto,
//       this.interests,
//       this.socialMediaLinks,
//       this.appId,
//       this.teams,
//       this.pendingRequests,
//       this.totalScore,
//       this.eventsParticipated,
//       this.sId,
//       this.iV});

//   User.fromJson(Map<String, dynamic> json) {
//     name = json['Name'];
//     emailId = json['email_id'];
//     profilePhoto = json['Profile_Photo'];
//     if (json['Interests'] != null) {
//       interests = <String>[];
//       json['Interests'].forEach((v) {
//         interests!.add(new String.fromJson(v));
//       });
//     }
//     if (json['SocialMedia_Links'] != null) {
//       socialMediaLinks = <Null>[];
//       json['SocialMedia_Links'].forEach((v) {
//         socialMediaLinks!.add(new Null.fromJson(v));
//       });
//     }
//     appId = json['App_id'];
//     if (json['Teams'] != null) {
//       teams = <Null>[];
//       json['Teams'].forEach((v) {
//         teams!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['Pending_Requests'] != null) {
//       pendingRequests = <Null>[];
//       json['Pending_Requests'].forEach((v) {
//         pendingRequests!.add(new Null.fromJson(v));
//       });
//     }
//     totalScore = json['Total_Score'];
//     if (json['Events_Participated'] != null) {
//       eventsParticipated = <Null>[];
//       json['Events_Participated'].forEach((v) {
//         eventsParticipated!.add(new Null.fromJson(v));
//       });
//     }
//     sId = json['_id'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Name'] = this.name;
//     data['email_id'] = this.emailId;
//     data['Profile_Photo'] = this.profilePhoto;
//     if (this.interests != null) {
//       data['Interests'] = this.interests!.map((v) => v.toJson()).toList();
//     }
//     if (this.socialMediaLinks != null) {
//       data['SocialMedia_Links'] =
//           this.socialMediaLinks!.map((v) => v.toJson()).toList();
//     }
//     data['App_id'] = this.appId;
//     if (this.teams != null) {
//       data['Teams'] = this.teams!.map((v) => v.toJson()).toList();
//     }
//     if (this.pendingRequests != null) {
//       data['Pending_Requests'] =
//           this.pendingRequests!.map((v) => v.toJson()).toList();
//     }
//     data['Total_Score'] = this.totalScore;
//     if (this.eventsParticipated != null) {
//       data['Events_Participated'] =
//           this.eventsParticipated!.map((v) => v.toJson()).toList();
//     }
//     data['_id'] = this.sId;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
