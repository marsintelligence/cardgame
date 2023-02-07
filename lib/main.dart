import 'package:cardgame/providers/crazyEightsGameProvider.dart';
import 'package:cardgame/providers/rummyGameProvider.dart';
import 'package:cardgame/screens/gameScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final crazyeightsProvider = ChangeNotifierProvider<CrazyEightsGameProvider>(
    (ref) => CrazyEightsGameProvider());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: GameScreen(),
    );
  }
}
