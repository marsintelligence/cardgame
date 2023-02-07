import 'package:cardgame/components/cardList.dart';
import 'package:cardgame/components/deckPile.dart';
import 'package:cardgame/components/discardPile.dart';
import 'package:cardgame/components/playerInfo.dart';
import 'package:cardgame/components/playingCard.dart';
import 'package:cardgame/main.dart';
import 'package:cardgame/models/cardModel.dart';
import 'package:cardgame/models/playerModel.dart';
import 'package:cardgame/providers/crazyEightsGameProvider.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameBoard extends ConsumerWidget {
  GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProvider = ref.watch(crazyeightsProvider);

    return gameProvider.currentDeck != null
        ? Column(
            children: [
              PlayerInfo(turn: gameProvider.turn),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                    child: DeckPile(
                                        remaining: gameProvider
                                            .currentDeck!.remaining),
                                    onTap: () async {
                                      await gameProvider.drawCard(
                                          gameProvider.turn.currentPlayer);
                                    }),
                                const SizedBox(width: 8),
                                DiscardPile(cards: gameProvider.discards)
                              ],
                            ),
                            if (gameProvider.bottomWidget != null)
                              gameProvider.bottomWidget!
                          ],
                        )),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CardList(
                        playerModel: gameProvider.players[1],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (gameProvider.turn.currentPlayer ==
                                      gameProvider.players[0])
                                    ElevatedButton(
                                        onPressed: gameProvider.canEndTurn()
                                            ? () {
                                                gameProvider.endTurn();
                                              }
                                            : null,
                                        child: const Text('End Turn')),
                                ],
                              ),
                            ),
                            CardList(
                              playerModel: gameProvider.players[0],
                              onPlayCard: (CardModel card) {
                                gameProvider.playCard(
                                  player: gameProvider.players[0],
                                  card: card,
                                );
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          )
        : TextButton(
            onPressed: (() async {
              await gameProvider.newGame([
                PlayerModel(name: "Munawwar", isHuman: true),
                PlayerModel(name: "Computer", isHuman: false)
              ]);
            }),
            child: const Text('New Game?'));
  }
}
