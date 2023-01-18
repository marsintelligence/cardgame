import 'package:flutter/material.dart';

enum Suit { Hearts, Clubs, Diamonds, Spades, Other }

class CardModel {
  final String image;
  final String value;
  final Suit suit;

  CardModel({required this.image, required this.value, required this.suit});
  factory CardModel.fromJson(Map<String, dynamic> json) {
    final Suit drawsuit = stringToSuit(json['suit']);
    return CardModel(
      image: json['image'],
      value: json['value'],
      suit: drawsuit,
    );
  }
  static Suit stringToSuit(String suit) {
    switch (suit.toUpperCase().trim()) {
      case 'HEARTS':
        return Suit.Hearts;
      case "SPADES":
        return Suit.Spades;
      case "DIAMONDS":
        return Suit.Diamonds;
      case "CLUBS":
        return Suit.Clubs;
      default:
        return Suit.Other;
    }
  }

  static String suitToString(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "HEARTS";
      case Suit.Clubs:
        return "CLUBS";
      case Suit.Diamonds:
        return "DIAMONDS";
      case Suit.Spades:
        return "SPADES";
      case Suit.Other:
        return "OTHER";
    }
  }

  static String suitToUnicode(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
        return "\u2665";
      case Suit.Clubs:
        return "\u2663";
      case Suit.Diamonds:
        return "\u2666";
      case Suit.Spades:
        return "\u2660";
      case Suit.Other:
        return "Other";
    }
  }

  static Color suitToColor(Suit suit) {
    switch (suit) {
      case Suit.Hearts:
      case Suit.Diamonds:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
