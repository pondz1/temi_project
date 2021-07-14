import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFF272C35),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment(0.0, 0.26),
        child: SizedBox(
          width: 1116.0,
          height: 1080.0,
          child: Column(
            children: <Widget>[
              Spacer(flex: 302),
              BorderedText(
                strokeWidth: 1,
                strokeColor: const Color(0xFF131C53),
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.miter,
                child: Text(
                  'Temi Funny',
                  style: TextStyle(
                    fontFamily: 'JasmineUPC',
                    fontSize: 200.0,
                    color: AppColors.primary,
                    letterSpacing: 25,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF5C1818).withOpacity(0.16),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 208),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(title: 'Flutter Demo Home Page'),
                    ),
                  );
                },
                child:
// Group: Group 1
                    Container(
                  alignment: Alignment(0.0, 0.02),
                  width: 435.0,
                  height: 109.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: AppColors.primary,
                  ),
                  child: BorderedText(
                    strokeWidth: 1,
                    strokeColor: Colors.red,
                    strokeCap: StrokeCap.butt,
                    strokeJoin: StrokeJoin.miter,
                    child: Text(
                      'คลิกที่นี่',
                      style: GoogleFonts.kanit(
                        fontSize: 60.0,
                        color: Colors.white,
                        letterSpacing: 6,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 177),
            ],
          ),
        ),
      ),
    );
  }
}
