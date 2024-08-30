/// Holds an model for the Trade Airtable base
class Trade {
  String? playerName;
  String? trade1Name;
  String? trade2Name;
  String? trade3Name;
  String? tradeFor1Name;
  String? tradeFor2Name;
  String? tradeFor3Name;
  int? gameWeekStartDate;
  String? id;

  Trade(
      {this.playerName,
      this.trade1Name,
      this.trade2Name,
      this.trade3Name,
      this.gameWeekStartDate});

  Trade.fromJson(Map<String, dynamic> json, String this.id) {
    playerName = json['Name'];
    trade1Name = json['Trade #1 Name'];
    tradeFor1Name = json['Trade For #1 Name'];
    trade2Name = json['Trade #2 Name'];
    tradeFor2Name = json['Trade For #2 Name'];
    trade3Name = json['Trade #3 Name'];
    tradeFor3Name = json['Trade For #3 Name'];
    gameWeekStartDate = json['GW Start Date (MS)'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (playerName != null) data['Name'] = playerName;
    if (trade1Name != null) data['Trade #1 Name'] = trade1Name;
    if (tradeFor1Name != null) data['Trade For #1 Name'] = tradeFor1Name;
    if (trade2Name != null) data['Trade #2 Name'] = trade2Name;
    if (tradeFor2Name != null) data['Trade For #2 Name'] = tradeFor2Name;
    if (trade3Name != null) data['Trade #3 Name'] = trade3Name;
    if (tradeFor3Name != null) data['Trade For #3 Name'] = tradeFor3Name;
    if (gameWeekStartDate != null) {
      data['GW Start Date (MS)'] = gameWeekStartDate;
    }

    // Handle encoding for both update and create
    if (id != null) {
      return {"fields": data, "id": id};
    } else {
      return {"fields": data};
    }
  }
}
