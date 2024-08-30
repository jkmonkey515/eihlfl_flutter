///Holds the Admin Airtable model
class Admin {
  String? gWTeamsColumnTableName;
  String? weekName;

  Admin({this.gWTeamsColumnTableName, this.weekName});

  Admin.fromJson(Map<String, dynamic> json) {
    gWTeamsColumnTableName = json['GW Teams | Column Name'];
    weekName = json['Week Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GW Teams | Column Name'] = gWTeamsColumnTableName;
    data['Week Name'] = weekName;
    return data;
  }
}
