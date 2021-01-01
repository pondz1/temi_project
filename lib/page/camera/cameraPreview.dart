import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraDownload.dart';

class CameraPreview extends StatefulWidget {
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
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
                  child: Image.asset("assets/images/979076.jpg"),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                //TODO: onTap Group 8
                print('onTap Group 8');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    CameraDownload())
                ).then((value) => {
                  setState((){
                  })
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: 535.0,
                height: 92.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xFFBE3F55),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF707070),
                  ),
                ),
                child: BorderedText(
                  //TODO: install bordered_text package
                  strokeWidth: 1,
                  strokeColor: Colors.black,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.miter,
                  child: Text(
                    'download picture',
                    style: TextStyle(
                      fontFamily: 'JasmineUPC',
                      fontSize: 40.0,
                      color: Colors.black,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
