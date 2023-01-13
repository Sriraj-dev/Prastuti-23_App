

//TODO: Get the Endpoints from backend Team.
class AppEndPoints{

  static const String baseUrl = "https://prastuti-2023.onrender.com/api";
  //authentication Urls:
  static const String loginUrl = baseUrl + "/login";

  // //registrationForm:
  // static const String registrationUrl = baseUrl+"/registrationForm";

  //Events:
  static const String eventsUrl = baseUrl + "/events";
  static const String _eventByIdUrl = baseUrl + "/events";
  String eventByIdUrl(String id) => _eventByIdUrl+"/$id";

  //Event Registration
  static const String soloRegistrationUrl = baseUrl + "/soloRegistration";
  static const String teamRegistrationUrl = baseUrl + "/teamRegistration";

  //leaderboard:
  static const String leaderboardUrl = baseUrl + "/leaderboard";
  static const String _eventsLeaderboardUrl = baseUrl + "/leaderboard";
  String eventsLeaderboardUrl(String eventName) => _eventsLeaderboardUrl+"/$eventName";


  //Score:
  static const String soloScoreUrl = baseUrl+"/soloScore";
  static const String teamScoreUrl = baseUrl + "/teamScore";

  //Teams:
  static const String createTeamUrl = baseUrl +"/teams";
  static const String _getTeamUrl = baseUrl +"/teams";
  String getTeamUrl(String id) => _getTeamUrl + "/$id";

  //User:
  String getUser(String id) => baseUrl + "/user/$id";//getRequest
  String editUser(String id) => baseUrl + "/user/$id";//PutReqquest
  String getAllUsers(String id) => baseUrl + "/user";//getRequest

  //Requests:
  static const String sendRequest = baseUrl + "/request";
  static const String acceptRequest = baseUrl + "/request/accept";
  static const String deleteRequest = baseUrl + "/request/delete";
}

