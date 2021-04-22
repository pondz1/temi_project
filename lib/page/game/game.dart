import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:flutter_temi_project/page/game/spotTheDifference/spotTheDifference.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent.withOpacity(0.1),
      // ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 40,
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, left: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.videogame_asset_rounded,
                        size: 180,
                        color: AppColors.primary,
                      ),
                      BorderedText(
                        strokeWidth: 5,
                        strokeColor: AppColors.primary,
                        strokeCap: StrokeCap.butt,
                        strokeJoin: StrokeJoin.miter,
                        child: Text(
                          'GAME',
                          style: TextStyle(
                            fontFamily: 'JasmineUPC',
                            fontSize: 80.0,
                            color: AppColors.primary,
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
                // InkWell(
                //   onTap: () {
                //     print("tap");
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => GamePlay1(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(60.0),
                //       child: Image.asset(
                //         "assets/images/game1.jpg",
                //         height: 400,
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    print("tap");
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SpotTheDifference(),
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
