import 'package:flutter/material.dart';
import 'package:cardgame/constants.dart';

class CardBack extends StatelessWidget {
  const CardBack({
    Key? key,
    this.size = 1,
    this.child,
  }) : super(key: key);

  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.blueGrey),
      child: child ?? Container(),
    );
  }
}
