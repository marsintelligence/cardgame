import 'package:cardgame/components/playingCard.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/models/cardModel.dart';
import 'package:cardgame/models/playerModel.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final double size;

  final PlayerModel playerModel;
  final int index;

  final Function(CardModel cardModel)? onPlayCard;
  const CardList({
    Key? key,
    this.size = 1,
    required this.playerModel,
    this.onPlayCard,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: CARD_HEIGHT * size,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: playerModel.cards.length,
          itemBuilder: ((context, index) {
            return PlayingCard(
              card: playerModel.cards[index],
              size: size,
              visible: true,
              onPlayCard: onPlayCard,
            );
          }),
        ));
  }
}
