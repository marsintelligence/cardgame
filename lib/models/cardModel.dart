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

  int cardValue(String value) {
    switch (value) {
      case 'ACE':
        return 14;
      case 'KING':
        return 13;
      case 'QUEEN':
        return 12;
      case 'JACK':
        return 11;
      case '10':
        return 10;
      case '9':
        return 9;
      case '8':
        return 8;
      case '7':
        return 7;
      case '6':
        return 6;
      case '5':
        return 5;
      case '4':
        return 4;
      case '3':
        return 3;
      case '2':
        return 2;
      case '1':
        return 1;
      default:
        return 15;
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
