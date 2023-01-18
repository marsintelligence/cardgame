import 'package:flutter/material.dart';
import 'package:cardgame/constants.dart';

class CardFront extends StatelessWidget {
  const CardFront({
    this.size = 1,
    this.child,
    Key? key,
  }) : super(key: key);

  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black45, width: 2)),
      child: child ?? Container(),
    );
  }
}
