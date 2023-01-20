import 'package:cardgame/models/drawModel.dart';
import 'package:cardgame/models/playerModel.dart';

class TurnModel {
  final List<PlayerModel> players;
  int index;
  PlayerModel currentPlayer;
  int drawCount;
  int actionCount;

  TurnModel(
      {required this.players,
      this.index = 0,
      required this.currentPlayer,
      this.drawCount = 0,
      this.actionCount = 0});

  PlayerModel get otherPlayer {
    return players.firstWhere((p) => p != currentPlayer);
  }

  void nextTurn() {
    index = index + 1;
    currentPlayer = (index % 2 == 0) ? players[0] : players[1];
    drawCount = 0;
    actionCount = 0;
  }
}
