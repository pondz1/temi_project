import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpotTheDifference extends StatefulWidget {
  @override
  _SpotTheDifferenceState createState() => _SpotTheDifferenceState();
}

class _SpotTheDifferenceState extends State<SpotTheDifference> {
  // answer
  // https://www.insider.com/spot-the-difference-beach-pictures-brainteaser-2020-6
  Timer _timer;
  int _start = 0;
  int _stop = 60; // time play (sec)
  int _err = 10; // ค่าตวามตลาดเคลื่อนของจุด
  int _countCorrect = 0;
  int _countWrong = 0;
  int _numMaxCorrect = 7;
  int _numMaxWrong = 3;

  List<Offset> _pointL = [
    Offset(483.8, 444.1),
    Offset(175.4, 420.2),
    Offset(422.3, 334.2),
    Offset(246.4, 313.7),
    Offset(239.9, 263.3),
    Offset(169.4, 252.3),
    Offset(341.8, 104.4)
  ];
  List<Offset> _pointR = [
    Offset(964.5, 443.1),
    Offset(656.2, 419.2),
    Offset(901.1, 333.2),
    Offset(726.1, 313.7),
    Offset(721.6, 261.8),
    Offset(647.2, 253.3),
    Offset(819.6, 104.9)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("\t Correct : " + _countCorrect.toString() + "\t Wrong : " + _countWrong.toString()),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        height: double.maxFinite,
        child: new Stack(
          //alignment:new Alignment(x, y)
          children: <Widget>[
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://i.insider.com/5ef364faaee6a85506725c35?width=1000&format=jpeg&auto=webp",
                        height: 500,
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
                        center: Text("เหลือเวลาอีก " +
                            (_stop - _start).toString() +
                            " วินาที"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onTapUp(TapUpDetails details) {
    print(details.localPosition);
    if (_isPoint(details.localPosition)) {
      _countCorrect++;
      print("Correct " + _countCorrect.toString());
    }else{
      _countWrong++;
      print("Wrong " + _countWrong.toString());
    }
    if (_countCorrect == _numMaxCorrect) {
      print("Win");
    }
    if(_countWrong == _numMaxWrong){
      print("Lose");
    }
    setState(() {});
  }

  bool _isPoint(Offset tapPoint) {
    bool result = false;
    for (int i = 0; i < _pointR.length; i++) {
      var disR = _pointR[i] - tapPoint;
      var disL = _pointL[i] - tapPoint;
      if (disR.dx < _err &&
              disR.dx > _err * (-1) &&
              disR.dy < _err &&
              disR.dy > _err * (-1) ||
          disL.dx < _err &&
              disL.dx > _err * (-1) &&
              disL.dy < _err &&
              disL.dy > _err * (-1)) {
        result = true;
        _pointR.removeAt(i);
        _pointL.removeAt(i);
      }
    }
    return result;
  }
}
