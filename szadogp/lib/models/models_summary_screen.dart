class Product {
  String name;
  double price;
  String quantity;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class UserInfo {
  String id;
  String username;
  UserInfo({
    required this.id,
    required this.username,
  });
}

class TeamGroups {
  int groupIdentifier;
  List<UserInfo> users;
  TeamGroups({
    required this.groupIdentifier,
    required this.users,
  });
}

class Ranking {
  int groupIdentifier;
  int place;
  Ranking({
    required this.groupIdentifier,
    required this.place,
  });
}

class SummaryRankingToSend {
  List<Ranking> ranking;
  String note;
  SummaryRankingToSend({
    required this.ranking,
    required this.note,
  });
}

class SummaryData {
  String id;
  Map<String, dynamic> boardGameId;

  String creatorId;
  List<UserInfo> users;
  List<TeamGroups> groups;

  SummaryData({
    required this.id,
    required this.boardGameId,
    required this.creatorId,
    required this.users,
    required this.groups,
  });
}
