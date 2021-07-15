

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbfbfb),
      // backgroundColor: Colors.white,
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // BorderedText(
                //   strokeWidth: 1,
                //   strokeColor: const Color(0xFF131C53),
                //   strokeCap: StrokeCap.butt,
                //   strokeJoin: StrokeJoin.miter,
                //   child: Text(
                //     'Temi Funny',
                //     style: TextStyle(
                //       fontFamily: 'JasmineUPC',
                //       fontSize: 60.0,
                //       color: AppColors.primary,
                //       letterSpacing: 25,
                //       fontWeight: FontWeight.w700,
                //       shadows: [
                //         Shadow(
                //           color: const Color(0xFF5C1818).withOpacity(0.16),
                //           offset: Offset(0, 3.0),
                //           blurRadius: 6.0,
                //         ),
                //       ],
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // Image.asset('assets/gif/tenor.gif'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: 'Flutter Demo Home Page'),
                      ),
                    );
                  },
                  child: Image.asset('assets/gif/eye2.gif',scale: 0.65,),


                  // Container(
                  //   alignment: Alignment(0.0, 0.02),
                  //   width: 300.0,
                  //   height: 80.0,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50.0),
                  //     color: AppColors.primary,
                  //   ),
                  //   child: BorderedText(
                  //     strokeWidth: 1,
                  //     strokeColor: Colors.red,
                  //     strokeCap: StrokeCap.butt,
                  //     strokeJoin: StrokeJoin.miter,
                  //     child: Text(
                  //       'คลิกที่นี่',
                  //       style: GoogleFonts.kanit(
                  //         fontSize: 40.0,
                  //         color: Colors.white,
                  //         letterSpacing: 6,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class FirstPage extends StatelessWidget {
//   const FirstPage({Key key}) : super(key: key);
//
// }
