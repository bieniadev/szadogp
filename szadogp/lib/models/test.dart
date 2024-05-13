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

class GameSummary {
  String id;
  Map<String, dynamic> boardGameId;
  String code;
  String status;
  String creatorId;
  List<UserInfo> users;
  List<TeamGroups> groups;
  List<dynamic> ranking;
  String createdAt;
  String updatedAt;
  int vValue;
  String startedAt;
  String finishedAt;

  GameSummary({
    required this.id,
    required this.boardGameId,
    required this.code,
    required this.status,
    required this.creatorId,
    required this.users,
    required this.groups,
    required this.ranking,
    required this.createdAt,
    required this.updatedAt,
    required this.vValue,
    required this.startedAt,
    required this.finishedAt,
  });
}

    // {
    //_id: 664129c14b648461ac6586c6, 
    //boardGameId: {_id: 663d12b800edff98b2c91d8d, name: Terraformacja Marsa, imageUrl: https://ik.imagekit.io/szadogp/terraformacja-marsa.jpg?updatedAt=1715278480856, maxPlayers: 5}, 
    //code: OD01VT, 
    //status: CLOSING_LOBBY, 
    //creatorId: 663d2d6bb91965ae304f4394, 
    //users: [{_id: 663d2d6bb91965ae304f4394, username: sigma1337}, {_id: 663a7572cf6ea2b33f6e8804, username: Benia}], 
    //groups: [{groupIdentifier: 1, users: [{_id: 663d2d6bb91965ae304f4394, username: sigma1337}]{groupIdentifier: 2, users: [{_id: 663a7572cf6ea2b33f6e8804, username: Benia}]}],
    //ranking: [], 
    //createdAt: 2024-05-12T20:42:41.933Z, 
    //updatedAt: 2024-05-12T20:45:48.578Z, 
    //__v: 0, 
    //startedAt: 2024-05-12T20:43:08.448Z, 
    //finishedAt: 2024-05-12T20:45:48.578Z
    //}

