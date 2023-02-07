import 'package:cardgame/components/gameBoard.dart';
import 'package:cardgame/main.dart';
import 'package:cardgame/providers/crazyEightsGameProvider.dart';
import 'package:cardgame/providers/rummyGameProvider.dart';
import 'package:cardgame/services/deckService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/playerModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late CrazyEightsGameProvider gameProvider;
  late final RummyGameProvider rummyGameProvider;
  @override
  void initState() {
    super.initState();

    //rummyGameProvider = Provider.of<RummyGameProvider>(context, listen: false);
  }

  /*void tempFunction() async {
    final service = DeckService();
    final deck = await service.newDeck();
    String newDeckId = deck.deckId;
    print(deck.remaining);
    final drawData = await service.drawCard(deck);
    print(drawData.cards.first.value);
    print(drawData.remaining);
  }*/

  @override
  Widget build(BuildContext context) {
    gameProvider = ref.watch(crazyeightsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game'),
        actions: [
          TextButton(
              onPressed: () async {
                List<PlayerModel> players = [
                  PlayerModel(name: "Munawwar", isHuman: true),
                  PlayerModel(
                    name: "Computer",
                    isHuman: false,
                  ),
                ];

                await gameProvider.newGame(players);
              },
              child: const Text('New Game'))
        ],
      ),
      body: GameBoard(),
    );
  }
}
