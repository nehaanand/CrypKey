class ModelHomePage {
  String username;

  ModelHomePage(this.username);

  ModelHomePage.map(dynamic obj) {
    this.username = obj["MESSAGE"];
  }
  String get _username => username;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_username"] = username;
    return map;
  }
}