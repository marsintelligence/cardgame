import 'package:cardgame/providers/crazyEightsGameProvider.dart';
import 'package:cardgame/providers/rummyGameProvider.dart';
import 'package:cardgame/screens/gameScreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final crazyeightsProvider = ChangeNotifierProvider<CrazyEightsGameProvider>(
    (ref) => CrazyEightsGameProvider());

final navigatorKey = GlobalKey<NavigatorState>();
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
<<<<<<< HEAD
  runApp(const ProviderScope(child: MyApp()));
=======
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CrazyEightsGameProvider()),
    ChangeNotifierProvider(create: (_) => RummyGameProvider()),
  ], child: const MyApp()));
>>>>>>> b52ee3b7f36caad9a4eec09f012488a70e46aa74
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
