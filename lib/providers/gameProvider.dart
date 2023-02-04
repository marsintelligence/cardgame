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

  Future<void> applyCardSideEffects(CardModel card) async {}

  Future<void> setupBoard() async {}
}
