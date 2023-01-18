import 'package:cardgame/providers/gameProvider.dart';

class CrazyEightsGameProvider extends GameProvider {
  @override
  Future<void> setupBoard() async {
    for (var p in players) {
      await drawCard(p, count: 8, allowAnyTime: true);
    }
    await drawCardToDiscardPile();
  }

  Future<void> drawCardToDiscardPile({int count = 1}) async {
    final drawnCards = await service.drawCard(currentDeck!, drawCount: count);
    discards.addAll(drawnCards.cards);
    notifyListeners();
  }
}
