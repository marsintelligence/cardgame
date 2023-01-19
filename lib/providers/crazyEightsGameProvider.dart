import 'package:cardgame/constants.dart';
import 'package:cardgame/providers/gameProvider.dart';

import '../models/cardModel.dart';

class CrazyEightsGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCard(p, count: 8, allowAnyTime: true);
    }
    await drawCardToDiscardPile();
    setLastCard(discardTop!);
  }

  @override
  bool canPlayCard(CardModel card) {
    bool canPlay = false;
    if (gameState[GS_LAST_CARD_SUIT] == null ||
        gameState[GS_LAST_CARD_VALUE] == null) {
      return false;
    }
    if (gameState[GS_LAST_CARD_SUIT] == card.suit) {
      return true;
    }
    if (gameState[GS_LAST_CARD_VALUE] == card.value) {
      return true;
    }
    if (card.value == "8") return true;
    return canPlay;
  }
}
