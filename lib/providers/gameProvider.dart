import 'package:cardgame/components/selectGameModal.dart';
import 'package:cardgame/constants.dart';
import 'package:cardgame/main.dart';
import 'package:cardgame/models/cardModel.dart';
import 'package:cardgame/models/turnModel.dart';
import 'package:cardgame/services/deckService.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/models/deckModel.dart';
import 'package:cardgame/models/playerModel.dart';

abstract class GameProvider with ChangeNotifier {
  GameProvider() {
    _service = DeckService();
  }
  late DeckService _service;
  DeckService get service {
    return _service;
  }

  late TurnModel _turn;
  TurnModel get turn {
    return _turn;
  }

  DeckModel? _currentDeck;
  DeckModel? get currentDeck {
    return _currentDeck;
  }

  late String option;

  List<PlayerModel> _players = [];
  List<PlayerModel> get players {
    return _players;
  }

  List<CardModel> _discards = [];
  List<CardModel> get discards {
    return _discards;
  }

  Widget? bottomWidget;

  CardModel? get discardTop => discards.isEmpty ? null : discards.last;
  Map<String, dynamic> gameState = {};

  void setBottomWidget(Widget? widget) {
    bottomWidget = widget;
    notifyListeners();
  }

  void setTrump(Suit suit) {
    setBottomWidget(Card(
      child: Text(
        CardModel.suitToUnicode(suit),
        style: TextStyle(
          color: CardModel.suitToColor(suit),
          fontSize: 24,
        ),
      ),
    ));
  }

  startNewGame() async {
    option = await showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) => SelectGameModal(),
    );
  }

  Future<void> newGame(List<PlayerModel> players) async {
    final deck = await service.newDeck();
    _currentDeck = deck;
    _players = players;
    _discards = [];
    _turn = TurnModel(players: players, currentPlayer: players.first);
    setupBoard();
    notifyListeners();
  }

  Future<void> drawCard(PlayerModel player,
      {int count = 1, bool allowAnyTime = false}) async {
    if (currentDeck == null) return;
    if (!allowAnyTime && !canDrawCard()) return;
    final drawCards = await service.drawCard(currentDeck!, drawCount: count);
    player.addCards(drawCards.cards);
    turn.drawCount += count;
    currentDeck!.remaining = drawCards.remaining;
    arrangeCards(player);
    setCards(player);
    notifyListeners();
  }

  setCards(PlayerModel player) {
    List rumsetpure = [];
    for (int i = 0; (i < player.cards.length) || (rumsetpure.length < 5); i++) {
      rumsetpure.add(player.cards[i]);
      for (int j = i + 1;
          (j < player.cards.length - 1) || (rumsetpure.length < 5);
          j++) {
        if (player.cards[i].suit == player.cards[j].suit) {
          if (player.cards[j].cardValue(player.cards[j].value) ==
              (player.cards[i].cardValue(player.cards[i].value) + 1)) {
            rumsetpure.add(player.cards[j]);
          }
        }
      }

      if (rumsetpure.length == 4) {
        for (var elem in rumsetpure) {
          player.cards.remove(elem);
        }
      } else {
        rumsetpure.clear();
      }
    }
    List createset(List cardset, int setLength) {
      cardset = [];
      for (int i = 0;
          i < player.cards.length || cardset.length < setLength + 1;
          i++) {
        rumsetpure.add(player.cards[i]);
        for (int j = i + 1;
            j < player.cards.length || cardset.length < setLength + 1;
            j++) {
          if (player.cards[i].suit == player.cards[j].suit) {
            if (player.cards[j].cardValue(player.cards[j].value) ==
                (player.cards[i].cardValue(player.cards[i].value) + 1)) {
              cardset.add(player.cards[j]);
            }
          }
        }

        if (cardset.length == (setLength - 1)) {
          for (var elem in cardset) {
            player.cards.remove(elem);
          }
        } else {
          cardset.clear();
        }
      }
      return cardset;
    }

    List rumset1 = [];
    rumset1 = createset(rumset1, 3);
    List rumset2 = [];
    rumset2 = createset(rumset2, 3);
    List rumset3 = [];
    rumset3 = createset(rumset3, 3);
    /*for (int i = 0; i < player.cards.length; i++) {
      rumset1.add(player.cards[i]);
      for (int j = i + 1; j < player.cards.length || rumset1.length < 4; j++) {
        if (player.cards[i].suit == player.cards[j].suit) {
          if (player.cards[j].cardValue(player.cards[j].value) ==
              (player.cards[i].cardValue(player.cards[i].value) + 1)) {
            rumset1.add(player.cards[j]);
          }
        }
      }
    }
    if (rumset1.length == 3) {
      for (var elem in rumset1) {
        player.cards.remove(elem);
      }
    } else {
      rumset1.clear();
    }
    List rumset2 = [];
    for (int i = 0; i < player.cards.length; i++) {
      for (int j = i + 1; j < player.cards.length && rumset1.length < 4; j++) {
        rumset2.add(player.cards[i]);
        if (player.cards[i].suit == player.cards[j].suit) {
          if (player.cards[j].cardValue(player.cards[j].value) ==
              (player.cards[i].cardValue(player.cards[i].value) + 1)) {
            rumset2.add(player.cards[j]);
          }
        }
      }
    }
    if (rumset2.length == 3) {
      for (var elem in rumset1) {
        player.cards.remove(elem);
      }
    } else {
      rumset2.clear();
    }
    List rumset3 = [];
    for (int i = 0; i < player.cards.length; i++) {
      for (int j = i + 1; j < player.cards.length && rumset1.length < 4; j++) {
        rumset3.add(player.cards[i]);
        if (player.cards[i].suit == player.cards[j].suit) {
          if (player.cards[j].cardValue(player.cards[j].value) ==
              (player.cards[i].cardValue(player.cards[i].value) + 1)) {
            rumset3.add(player.cards[j]);
          }
        }
      }
    }
    if (rumset3.length == 3) {
      for (var elem in rumset1) {
        player.cards.remove(elem);
      }
    } else {
      rumset3.clear();
    }*/
    addBackCards(List cardSet) {
      if (cardSet.isNotEmpty) {
        for (var elem in cardSet) {
          player.cards.remove(elem);
        }
        for (var elem in cardSet) {
          player.cards.add(elem);
        }
      }
    }

    addBackCards(rumsetpure);
    addBackCards(rumset1);
    addBackCards(rumset2);
    addBackCards(rumset3);
    notifyListeners();
  }

  Future<void> drawCardToDiscardPile({int count = 1}) async {
    final drawnCards = await service.drawCard(currentDeck!, drawCount: count);
    discards.addAll(drawnCards.cards);
    currentDeck!.remaining = drawnCards.remaining;
    notifyListeners();
  }

  bool canDrawCard() {
    return turn.drawCount < 1 && turn.actionCount < 1;
  }

  bool canEndTurn() {
    return turn.drawCount > 0;
  }

  endTurn() {
    turn.nextTurn();
    if (turn.currentPlayer.isBot) {
      botTurn();
    }
    notifyListeners();
  }

  Future<void> botTurn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    for (var card in turn.currentPlayer.cards) {
      await playCard(player: turn.currentPlayer, card: card);
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

  bool canPlayCard(CardModel card) {
    bool canPlay = true;
    if (turn.actionCount > 1 || gameIsOver) {
      canPlay = false;
    }
    return canPlay;
  }

  Future<void> playCard(
      {required PlayerModel player, required CardModel card}) async {
    if (turn.actionCount >= 1) {
      showToast("You cant play that");
      return;
    }

    if (canPlayCard(card) == false) return;
    player.removeCards(card);

    _discards.add(card);

    turn.actionCount = turn.actionCount + 1;
    showToast("${turn.currentPlayer.name}played a card ${turn.actionCount}");
    setLastCard(card);
    await applyCardSideEffects(card);
    if (gameIsOver) {
      finishGame();
    }
    notifyListeners();
  }

  void skipTurn() {
    turn.nextTurn();
    notifyListeners();
  }

  bool get gameIsOver {
    return currentDeck!.remaining < 1;
  }

  void finishGame() {
    showToast("Game Is Over");
    notifyListeners();
  }

  setLastCard(CardModel card) {
    gameState[GS_LAST_CARD_SUIT] = card.suit;
    gameState[GS_LAST_CARD_VALUE] = card.value;
    setTrump(card.suit);
  }

  void showToast(String msg, {int seconds = 3, SnackBarAction? action}) {
    rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: seconds),
      action: action,
    ));
  }

  bool canDrawFromDiscardPile() {
    bool canDraw = true;

    return canDraw;
  }

  Future<void> drawCardFromDiscardPile(
    PlayerModel player, {
    int count = 1,
  }) async {
    player.cards.add(discardTop!);
    discards.removeLast();
  }

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

  Future<void> applyCardSideEffects(CardModel card) async {}

  Future<void> setupBoard() async {}
}
