import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/gomoku_game.dart';

void main() {
  runApp(const GomokuApp());
}

class GomokuApp extends StatelessWidget {
  const GomokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cờ Caro đối kháng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const GomokuHomePage(),
    );
  }
}

class GomokuHomePage extends StatelessWidget {
  const GomokuHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cờ Caro đối kháng'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: GomokuGame(),
      ),
    );
  }
}
