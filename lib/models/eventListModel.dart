class EventListModel {
  List<Events>? events;

  EventListModel({this.events});

  EventListModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? sId;
  String? name;
  String? description;
  String? rules;
  String? rewards;
  List<Timeline>? timeline;
  int? noOfParticipants;
  bool? teamEvent;
  List<dynamic>? participants;
  List<dynamic>? teams;

  Events(
      {this.sId,
      this.name,
      this.description,
      this.rules,
      this.rewards,
      this.timeline,
      this.noOfParticipants,
      this.teamEvent,
      this.participants,
      this.teams});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    description = json['Description'];
    rules = json['rules'];
    rewards = json['rewards'];
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(new Timeline.fromJson(v));
      });
    }
    noOfParticipants = json['no_of_participants'];
    teamEvent = json['team_event'];
    if (json['Participants'] != null) {
      participants = <dynamic>[];
      json['Participants'].forEach((v) {
        participants!.add(v);
      });
    }
    if (json['teams'] != null) {
      teams = <dynamic>[];
      json['teams'].forEach((v) {
        teams!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['rules'] = this.rules;
    data['rewards'] = this.rewards;
    if (this.timeline != null) {
      data['timeline'] = this.timeline!.map((v) => v.toJson()).toList();
    }
    data['no_of_participants'] = this.noOfParticipants;
    data['team_event'] = this.teamEvent;
    if (this.participants != null) {
      data['Participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeline {
  String? sId;
  String? date;
  String? slot;
  String? title;
  bool? isCompleted;

  Timeline({this.sId, this.date, this.slot, this.title, this.isCompleted});

  Timeline.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['Date'];
    slot = json['slot'];
    title = json['title'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Date'] = this.date;
    data['slot'] = this.slot;
    data['title'] = this.title;
    data['is_completed'] = this.isCompleted;
    return data;
  }
}
