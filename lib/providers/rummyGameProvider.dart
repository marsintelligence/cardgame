import 'package:cardgame/models/cardModel.dart';
import 'package:cardgame/providers/gameProvider.dart';

import '../models/playerModel.dart';

class RummyGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCard(
        p,
        count: 13,
        allowAnyTime: true,
      );
    }
  }

  @override
  void arrangeCards(PlayerModel player) {
    var playerCards = player.cards;
    List<CardModel>? spadeCards = [];
    List<CardModel>? diamondCards = [];
    List<CardModel>? heartCards = [];
    List<CardModel>? clubCards = [];
    List<CardModel>? otherCards = [];

    for (int i = 0; i < playerCards.length; i++) {
      if (playerCards[i].suit == Suit.Clubs) {
        clubCards.add(playerCards[i]);
      }

      if (playerCards[i].suit == Suit.Diamonds) {
        diamondCards.add(playerCards[i]);
      }
      if (playerCards[i].suit == Suit.Hearts) {
        heartCards.add(playerCards[i]);
      }
      if (playerCards[i].suit == Suit.Spades) {
        spadeCards.add(playerCards[i]);
      }
      if (playerCards[i].suit == Suit.Other) {
        otherCards.add(playerCards[i]);
      }
    }

    clubCards
        .sort((a, b) => a.cardValue(a.value).compareTo(b.cardValue(b.value)));
    List<CardModel>? sortCards(List<CardModel> cards) {
      for (CardModel card in cards) {
        if (card.value == "ACE") {
          card.cardValue(card.value);
        }
      }
      cards
          .sort((a, b) => a.cardValue(a.value).compareTo(b.cardValue(b.value)));
      return cards;
    }

    sortCards(diamondCards);
    sortCards(heartCards);
    sortCards(spadeCards);

    //playerCards.clear();
    player.cards = [
      ...clubCards,
      ...spadeCards,
      ...heartCards,
      ...diamondCards
    ];
  }
}
