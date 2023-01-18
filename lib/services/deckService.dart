import 'package:cardgame/models/deckModel.dart';
import 'package:cardgame/models/drawModel.dart';
import 'package:cardgame/services/apiService.dart';

class DeckService extends ApiService {
  Future<DeckModel> newDeck([int deckCount = 1]) async {
    final data = await httpget('/deck/new/shuffle', params: {
      'deck_count': deckCount,
    });
    return DeckModel.fromJson(data);
  }

  Future<DrawModel> drawCard(DeckModel deck, {int drawCount = 1}) async {
    final data = await httpget('/deck/${deck.deckId}/draw', params: {
      'count': drawCount,
    });
    return DrawModel.fromJson(data);
  }
}
