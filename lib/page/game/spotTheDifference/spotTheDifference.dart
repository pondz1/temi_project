import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:flutter_temi_project/page/game/spotTheDifference/spt_painter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'setting.dart' as setting;

class SpotTheDifference extends StatefulWidget {
  @override
  _SpotTheDifferenceState createState() => _SpotTheDifferenceState();
}

class _SpotTheDifferenceState extends State<SpotTheDifference> {
  // answer
  // https://i.insider.com/5ef36eaff34d050a883d5ad5?width=700&format=jpeg&auto=webp
  // ignore: unused_field
  Timer _timer;
  int _start = 0;
  int _stop = 60; // time play (sec)
  int _err = 30; // ค่าตวามตลาดเคลื่อนของจุด
  int _countCorrect = 0;
  int _countWrong = 0;
  int _numMaxCorrect = 7;
  int _numMaxWrong = 3;
  var imageLink = "https://i.insider.com/5ef364faaee6a85506725c35?width=1000&format=jpeg&auto=webp";

  List<Offset> _pointL = [
    Offset(455.1, 225.8),
    Offset(351.8, 390.3),
    Offset(275.9, 380.3),
    Offset(358.5, 443.6),
    Offset(543.7, 463.6),
    Offset(609.7, 582.2),
    Offset(285.2, 557.5)
  ];
  List<Offset> _pointR = [
    Offset(966.8, 225.8),
    Offset(862.9, 389.7),
    Offset(787.6, 380.3),
    Offset(870.9, 444.3),
    Offset(1056.1, 464.3),
    Offset(1122.1, 580.2),
    Offset(796.9, 555.5)
  ];
  List<Offset> _pointCorrect = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    selectGame();
  }

  void selectGame(){
    if(setting.number == 1){
      _pointL = [
        Offset(455.1, 225.8),
        Offset(351.8, 390.3),
        Offset(275.9, 380.3),
        Offset(358.5, 443.6),
        Offset(543.7, 463.6),
        Offset(609.7, 582.2),
        Offset(285.2, 557.5)
      ];
      _pointR = [
        Offset(966.8, 225.8),
        Offset(862.9, 389.7),
        Offset(787.6, 380.3),
        Offset(870.9, 444.3),
        Offset(1056.1, 464.3),
        Offset(1122.1, 580.2),
        Offset(796.9, 555.5)
      ];
    }
    else if(setting.number == 2){
      _numMaxCorrect = 11;
      imageLink = "https://imgs.heart.co.uk/images/215607?crop=16_9&width=660&relax=1&signature=kMKOiuaa2OmxY-o0Z2D1XkqvsTM=";
      _pointL = [
        Offset(439.3, 229.3),
        Offset(622.6, 236.0),
        Offset(398.6, 277.3),
        Offset(444.0, 290.6),
        Offset(356.0, 312.0),
        Offset(519.3, 342.0),
        Offset(520.0, 379.3),
        Offset(380.0, 457.3),
        Offset(402.6, 501.3),
        Offset(564.6, 534.0),
        Offset(465.3, 569.3)
      ];
      _pointR = [
        Offset(779.3, 224.7),
        Offset(955.3, 236.0),
        Offset(736.0, 276.6),
        Offset(778.0, 295.3),
        Offset(688.6, 312.0),
        Offset(856.6, 343.3),
        Offset(854.6, 377.3),
        Offset(712.6, 458.0),
        Offset(741.3, 502.6),
        Offset(893.3, 534.6),
        Offset(802.0, 562.0)
      ];
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == _stop) {
          setState(() {
            timer.cancel();
            print("หมดเวลา...");
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //     backgroundColor: AppColors.background,
      //     // title: Text("\t Correct : " +
      //     //     _countCorrect.toString() +
      //     //     "\t Wrong : " +
      //     //     _countWrong.toString()),
      //     title: Padding(
      //       padding: const EdgeInsets.only(right: 60),
      //       child: _buildLife()
      //     )),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        height: double.maxFinite,
        child: new Stack(
          //alignment:new Alignment(x, y)
          children: <Widget>[
            new Positioned(
              child: Padding(
                padding: const EdgeInsets.only(right: 80, top: 30),
                child: new Align(
                  alignment: FractionalOffset.topRight,
                  child: _buildLife(),
                ),
              ),
            ),
            new Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: new Align(
                  alignment: FractionalOffset.topCenter,
                  child: Text("เกมจับผิดภาพ",
                      style: GoogleFonts.kanit(
                        fontSize: 25.0,
                        color: AppColors.primary,
                      )),
                ),
              ),
            ),
            new Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 90),
                child: new Align(
                  alignment: FractionalOffset.topLeft,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogBack(context),
                      );
                    },
                    child: Text("ยอมแพ้",
                        style: GoogleFonts.kanit(
                          fontSize: 20.0,
                          color: AppColors.primary,
                        )),
                  ),
                ),
              ),
            ),
            // new Positioned(
            //   child: new Align(
            //       alignment: FractionalOffset.topLeft,
            //       child: Container(
            //         padding: const EdgeInsets.all(50.0),
            //         child: Row(
            //           children: [
            //             // IconButton(
            //             //   icon: Icon(
            //             //     Icons.arrow_back,
            //             //     size: 50,
            //             //   ),
            //             //   onPressed: () => Navigator.of(context).pop(),
            //             // ),
            //             // Text("\t Correct : " + _countCorrect.toString() + "\t Wrong : " + _countWrong.toString()),
            //           ],
            //         ),
            //       )),
            // ),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.center,
                child: GestureDetector(
                  onTapUp: (TapUpDetails details) => _onTapUp(details),
                  child: Stack(
                    children: [
                      Image.network(
                        imageLink,
                        height: MediaQuery.of(context).size.height - 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/gif/Alarm_Clock_GIF_Animation_High_Res.gif",
                        height: 100,
                        width: 100,
                      ),
                      LinearPercentIndicator(
                        padding: const EdgeInsets.only(left: 30, right: 50),
                        width: MediaQuery.of(context).size.width - 220,
                        lineHeight: 50.0,
                        percent: _start / _stop,
                        center: Text(
                            "เหลือเวลาอีก " +
                                (_stop - _start).toString() +
                                " วินาที",
                            style: GoogleFonts.kanit(
                              fontSize: 23.0,
                              color: Colors.white,
                            )),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // CustomPaint(
            //   painter: MyCirclePainter(offset: _pointL),
            // ),
            // CustomPaint(
            //   painter: MyCirclePainter(offset: _pointR),
            // ),
            CustomPaint(
              painter: MyCirclePainter(offset: _pointCorrect),
            ),
          ],
        ),
      ),
    );
  }

  _onTapUp(TapUpDetails details) {
    Offset offset = details.globalPosition;
    print(offset);
    // _pointR.add(offset);
    // print(_pointR);
    if (_isPoint(offset)) {
      _countCorrect++;
      print("Correct " + _countCorrect.toString());
      if (_countCorrect == _numMaxCorrect) {
        print("Win");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      }
    } else {
      _countWrong++;
      _numMaxWrong--;
      print("heart " + _numMaxWrong.toString());
      print("Wrong " + _countWrong.toString());
      if (_numMaxWrong == 0) {
        print("Lose");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      }
    }

    setState(() {});
  }

  bool _isPoint(Offset tapPoint) {
    bool result = false;
    for (int i = 0; i < _pointR.length; i++) {
      var disR = _pointR[i] - tapPoint + Offset(0,16);
      var disL = _pointL[i] - tapPoint + Offset(0,16);
      if (disR.dx < _err &&
              disR.dx > _err * (-1) &&
              disR.dy < _err &&
              disR.dy > _err * (-1) ||
          disL.dx < _err &&
              disL.dx > _err * (-1) &&
              disL.dy < _err &&
              disL.dy > _err * (-1)) {
        result = true;
        _pointCorrect.add(_pointR[i]);
        _pointCorrect.add(_pointL[i]);
        _pointR.removeAt(i);
        _pointL.removeAt(i);
      }
    }
    return result;
  }

  Widget _buildLife() {
    if (_numMaxWrong == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Icon(
          //   Icons.favorite,
          //   size: 40,
          // ),
          // Icon(
          //   Icons.favorite,
          //   size: 40,
          // ),
          // Icon(
          //   Icons.favorite,
          //   size: 40,
          // )
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
        ],
      );
    }
    if (_numMaxWrong == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
        ],
      );
    }
    if (_numMaxWrong == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "assets/gif/source.gif",
            height: 70,
            width: 70,
          ),
        ],
      );
    }
    return Row();
  }

  Widget _buildPopupDialog(BuildContext context) {
    _timer.cancel();
    return new AlertDialog(
      title: _countCorrect == _numMaxCorrect
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/win.gif",
                  height: 70,
                  width: 70,
                ),
                Container(
                  width: 20,
                ),
                Text('ยินดีด้วยคุณชนะ',
                    style: GoogleFonts.kanit(
                      fontSize: 25.0,
                      color: AppColors.primary,
                    )),
                Container(
                  width: 20,
                ),
                Image.asset(
                  "assets/gif/win.gif",
                  height: 70,
                  width: 70,
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/lose.gif",
                  height: 70,
                  width: 70,
                ),
                Container(
                  width: 20,
                ),
                Text('เสียใจด้วยนะ',
                    style: GoogleFonts.kanit(
                      fontSize: 25.0,
                      color: AppColors.primary,
                    )),
                Container(
                  width: 20,
                ),
                Image.asset(
                  "assets/gif/lose.gif",
                  height: 70,
                  width: 70,
                )
              ],
            ),
      content: _countCorrect == _numMaxCorrect
          ? new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/qr.png",
                  height: 300,
                  width: 300,
                ),
                Text('แสกนเพื่อรับรางวัล'),
              ],
            )
          : new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('T_T')],
            ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          textColor: Colors.black54,
          child: const Text('กลับสู่หน้าหลัก'),
        ),
        new FlatButton(
          onPressed: () {
            setting.number++;
            if(setting.number > setting.max){
              setting.number = 1;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SpotTheDifference(),
              ),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('เกมถัดไป'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogBack(BuildContext context) {
    return new AlertDialog(
      title: Text("คุณมั่นใจไหมที่จะยอมแพ้?"),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('ยอมแพ้'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.black54,
          child: const Text('ยกเลิก'),
        ),
      ],
    );
  }
}
