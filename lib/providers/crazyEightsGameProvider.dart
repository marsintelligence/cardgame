import 'package:cardgame/components/suitPickerModal.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/main.dart';
import 'package:cardgame/providers/gameProvider.dart';
import 'package:flutter/material.dart';

import '../models/cardModel.dart';

class CrazyEightsGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCard(p, count: 13, allowAnyTime: true);
      //arrangeCards(p);
    }
    await drawCardToDiscardPile();
    setLastCard(discardTop!);
    turn.actionCount = 0;
    turn.drawCount = 0;
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
          player: turn.currentPlayer, card: turn.currentPlayer.cards.last);
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
    if (turn.actionCount > 1 || gameIsOver) {
      canPlay = false;
    }
    return canPlay;
  }

  @override
  bool canEndTurn() {
    if (turn.drawCount > 0 || turn.actionCount > 0) {
      return true;
    }
    return false;
  }

  @override
  bool get gameIsOver {
    if (currentDeck!.remaining < 1 || turn.currentPlayer.cards.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void finishGame() {
    showToast("Game Over. ${turn.currentPlayer.name} won");
  }

  @override
  Future<void> applyCardSideEffects(CardModel card) async {
    if (card.value == "8") {
      Suit? suit;
      if (turn.currentPlayer.isHuman) {
        suit = await showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (_) => SuitPickerModal(),
        );
      } else {
        suit = turn.currentPlayer.cards.first.suit;
      }
      gameState[GS_LAST_CARD_SUIT] = suit;
      setTrump(card.suit);
    } else if (card.value == "2") {
      await drawCard(turn.otherPlayer, count: 2, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} had to draw two cards");
    } else if (card.value == "QUEEN" && card.suit == Suit.Spades) {
      await drawCard(turn.otherPlayer, count: 5, allowAnyTime: true);
      showToast("${turn.otherPlayer.name} had to draw five cards");
    } else if (card.value == "JACK") {
      showToast("${turn.otherPlayer.name} missed a turn");
      skipTurn();
      skipTurn();
      notifyListeners();
    }
  }
}
