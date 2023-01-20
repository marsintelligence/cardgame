import 'dart:html';

import 'package:cardgame/constants.dart';
import 'package:cardgame/providers/gameProvider.dart';

import '../models/cardModel.dart';

class CrazyEightsGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCard(p, count: 4, allowAnyTime: true);
    }
    await drawCardToDiscardPile();
    setLastCard(discardTop!);
  }

  @override
  Future<void> botTurn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (var card in turn.currentPlayer.cards) {
      if (canPlayCard(card)) {
        await playCard(player: turn.currentPlayer, card: card);
        endTurn();
        return;
      }
    }

    await drawCard(turn.currentPlayer);
    await Future.delayed(const Duration(milliseconds: 500));

    if (turn.currentPlayer.cards.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      await playCard(
          player: turn.currentPlayer, card: turn.currentPlayer.cards.first);
    }
    if (canEndTurn()) endTurn();
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
    if (card.value == "8") canPlay = true;
    return canPlay;
  }

  @override
  bool canEndTurn() {
    if (turn.drawCount > 0 || turn.actionCount > 0) {
      return true;
    }
    return false;
  }
}
