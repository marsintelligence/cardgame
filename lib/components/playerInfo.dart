import 'package:cardgame/models/playerModel.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/models/turnModel.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    Key? key,
    this.players,
    required this.turn,
  }) : super(key: key);

  final List<PlayerModel>? players;

  final TurnModel turn;
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: double.infinity,
      child: (Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: turn.players.map((player) {
            final isCurrent = turn.currentPlayer == player;
            return (Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: isCurrent ? Colors.black : Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("${player.name} (${player.cards.length})",
                    style: TextStyle(
                      color: isCurrent ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ));
          }).toList())),
    );
  }
}
