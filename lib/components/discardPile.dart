import 'package:cardgame/components/playingCard.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/components/cardFront.dart';

import '../models/cardModel.dart';

class DiscardPile extends StatelessWidget {
  const DiscardPile({
    Key? key,
    this.size = 1,
    this.cards,
  }) : super(key: key);

  final double size;
  final List<CardModel>? cards;

  @override
  Widget build(BuildContext context) {
    return CardFront(
        size: size,
        child: Stack(
          children: cards!
              .map((card) => PlayingCard(card: card, visible: true))
              .toList(),
        ));
  }
}
