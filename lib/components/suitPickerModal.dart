import 'package:cardgame/models/cardModel.dart';
import 'package:flutter/material.dart';

class SuitOption {
  final Suit value;
  late Color color;

  SuitOption({required this.value, required this.color});
}

class SuitPickerModal extends StatelessWidget {
  const SuitPickerModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SuitOption> suits = [
      SuitOption(value: Suit.Clubs, color: CardModel.suitToColor(Suit.Clubs)),
      SuitOption(
          value: Suit.Diamonds, color: CardModel.suitToColor(Suit.Diamonds)),
      SuitOption(value: Suit.Spades, color: CardModel.suitToColor(Suit.Spades)),
      SuitOption(value: Suit.Hearts, color: CardModel.suitToColor(Suit.Hearts)),
    ];
    return AlertDialog(
        title: const Text("Choose a Suit"),
        content: Row(
          children: suits
              .map((suit) => TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(suit.value);
                    },
                    child: Text(CardModel.suitToUnicode(suit.value),
                        style: TextStyle(
                          color: suit.color,
                          fontSize: 32,
                        )),
                  ))
              .toList(),
        ));
  }
}
