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
  List<String>? playerIds;
  String? sId;
  String? name;
  String? description;
  String? rules;
  String? rewards;
  List<Timeline>? timeline;
  int? noOfParticipants;
  bool? teamEvent;
  List<Participants>? participants;
  List<TeamParticipants>? teams;

  Events(
      {this.playerIds,
      this.sId,
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
    playerIds = json['player_ids'].cast<String>();
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
      participants = <Participants>[];
      json['Participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    if (json['teams'] != null) {
      teams = <TeamParticipants>[];
      json['teams'].forEach((v) {
        teams!.add(new TeamParticipants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_ids'] = this.playerIds;
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

class Participants {
  String? participant;
  int? score;
  String? sId;

  Participants({this.participant, this.score, this.sId});

  Participants.fromJson(Map<String, dynamic> json) {
    participant = json['participant'];
    score = json['Score'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participant'] = this.participant;
    data['Score'] = this.score;
    data['_id'] = this.sId;
    return data;
  }
}

class TeamParticipants {
  String? team;
  int? score;
  String? sId;

  TeamParticipants({this.team, this.score, this.sId});

  TeamParticipants.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    score = json['score'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team'] = this.team;
    data['score'] = this.score;
    data['_id'] = this.sId;
    return data;
  }
}
