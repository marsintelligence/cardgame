import 'package:cardgame/providers/crazyEightsGameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameOption {
  late String option;

  GameOption({required this.option});
}

class SelectGameModal extends StatelessWidget {
  const SelectGameModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<GameOption> options = [
      GameOption(option: "Crazy Eights"),
      GameOption(option: "Rummy")
    ];
    return AlertDialog(
        title: const Text("Choose Game"),
        content: Column(
          children: options
              .map((opt) => TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(opt.option);
                  },
                  child: Text(opt.option)))
              .toList(),
        ));
  }
}
