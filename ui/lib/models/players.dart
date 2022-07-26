class PlayersModel {
  String player1;
  String player2;
  String start;

  PlayersModel({
    required this.player1,
    required this.player2,
    required this.start,
  });

  Map<String, String?> toJson() => {
        'player1': player1,
        'player2': player2,
        'start': start,
      };

  PlayersModel.fromJson(Map<String, dynamic> json)
      : player1 = json['player1'],
        player2 = json['player2'],
        start = json['start'];

  PlayersModel.empty()
      : player1 = 'Laurent le BG',
        player2 = 'Elsa la BG',
        start = 'Laurent le BG';
}
