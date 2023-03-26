import 'package:flutter/material.dart';

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  int totalpomodoros = 0;

  void incrementPomodoros() {
    setState(() {
      totalpomodoros += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
