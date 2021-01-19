import 'package:flutter/material.dart';

class GamePlay1 extends StatefulWidget {
  @override
  _GamePlay1State createState() => _GamePlay1State();
}

class _GamePlay1State extends State<GamePlay1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.1),
      ),
      body: Container(
        color: Color(0xFF0E3139),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/game1.jpg",
                    height: 400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
