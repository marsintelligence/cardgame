import 'package:cardgame/models/cardModel.dart';

class PlayerModel {
  final String name;
  final bool isHuman;
  List<CardModel> cards;

  addCards(List<CardModel> newCards) {
    cards = [...cards, ...newCards];
  }

  removeCards(CardModel card) {
    return cards
        .removeWhere((c) => c.value == card.value && c.suit == card.suit);
  }

  bool get isBot {
    return !isHuman;
  }

  PlayerModel({
    required this.name,
    this.isHuman = false,
    this.cards = const [],
  });
}
