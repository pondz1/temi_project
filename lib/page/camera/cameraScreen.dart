import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraPreview.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<IconData> example = [
    Icons.navigate_before,
    Icons.ac_unit,
    Icons.account_balance,
    Icons.camera,
    Icons.accessibility,
    Icons.accessible_forward_outlined,
    Icons.navigate_next,
  ];
  var countText = "";
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onSelfie() {
    int _start = 4;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                CameraPreview())
            ).then((value) => {
              setState((){
                countText = "";
              })
            });
          });
        } else {
          setState(() {
            _start--;
            countText = _start.toString();
          });
        }
      },
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - 310,
                  width: MediaQuery.of(context).size.width - 190,
                )
              ],
            ),
            countText != ""
                ? Text(
                    countText,
                    style: TextStyle(fontSize: 120, color: Colors.white),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: example.map((e) {
                      var index = example.indexOf(e);
                      return iconFilter(e, index);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget iconFilter(IconData icon, int index) {
    var mid = (example.length / 2).floor();
    var size = index == mid ? 110.0 : 55.0;
    return Ink(
      decoration: ShapeDecoration(
        color: Colors.pink,
        shape: CircleBorder(),
      ),
      child: IconButton(
        color: Colors.white,
        disabledColor: Colors.white,
        iconSize: size,
        icon: Icon(icon),
        onPressed: () {
          onSelfie();
        },
      ),
    );
  }
}
