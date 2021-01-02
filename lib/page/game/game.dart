import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/game/gamePlay1.dart';
import 'package:flutter_temi_project/page/game/gamePlay2.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.videogame_asset_rounded,
                        size: 180,
                        color: Colors.white,
                      ),
                      BorderedText(
                        //TODO: install bordered_text package
                        strokeWidth: 5,
                        strokeColor: Colors.white,
                        strokeCap: StrokeCap.butt,
                        strokeJoin: StrokeJoin.miter,
                        child: Text(
                          'GAME',
                          style: TextStyle(
                            fontFamily: 'JasmineUPC',
                            fontSize: 80.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    print("tap");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GamePlay1(),
                        ),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.asset(
                          "assets/images/game1.jpg",
                        height: 400,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("tap");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GamePlay2(),
                        ),
                    );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.asset(
                        "assets/images/game2.jpg",
                        height: 400,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
