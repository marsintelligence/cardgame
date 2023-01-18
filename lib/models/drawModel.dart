import 'dart:convert';

import 'package:cardgame/models/cardModel.dart';
import 'package:flutter/material.dart';

class DrawModel {
  final bool success;
  final int remaining;
  List<CardModel> cards;

  DrawModel(
      {required this.success, required this.remaining, this.cards = const []});
  factory DrawModel.fromJson(Map<String, dynamic> json) {
    final rawCards = json['cards']
        .map<CardModel>((card) => CardModel.fromJson(card))
        .toList();

    return DrawModel(
      success: json['success'],
      remaining: json['remaining'],
      cards: rawCards,
    );
  }
}
