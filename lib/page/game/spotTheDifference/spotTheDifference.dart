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
  // https://i.insider.com/5ef36eaff34d050a883d5ad5?width=700&format=jpeg&auto=webp
  Timer _timer;
  int _start = 0;
  int _stop = 60; // time play (sec)
  int _err = 10; // ค่าตวามตลาดเคลื่อนของจุด
  int _countCorrect = 0;
  int _countWrong = 0;
  int _numMaxCorrect = 7;
  int _numMaxWrong = 3;

  List<Offset> _pointL = [
    Offset(456.3, 355.1),
    Offset(211.9, 333.6),
    Offset(407.3, 266.7),
    Offset(269.4, 251.2),
    Offset(263.4, 210.7),
    Offset(203.9, 201.2),
    Offset(342.8, 84.3)
  ];
  List<Offset> _pointR = [
    Offset(843.1, 354.6),
    Offset(598.2, 334.6),
    Offset(793.6, 266.7),
    Offset(651.7, 250.7),
    Offset(646.2, 209.7),
    Offset(589.2, 202.7),
    Offset(725.6, 83.3)
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
        title: Text("\t Correct : " +
            _countCorrect.toString() +
            "\t Wrong : " +
            _countWrong.toString()),
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
    // _pointR.add(details.localPosition);
    // print(_pointR);
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
