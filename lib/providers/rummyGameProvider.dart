import 'package:cardgame/providers/gameProvider.dart';

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
    drawCardToDiscardPile();
  }
}
