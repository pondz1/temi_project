import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class CameraDownload extends StatefulWidget {
  @override
  _CameraDownloadState createState() => _CameraDownloadState();
}

class _CameraDownloadState extends State<CameraDownload> {
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
                  Image.asset(
                    "assets/images/qr.png",
                    height: 360,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Group: Group 9
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    width: 700.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFF707070).withOpacity(0.7),
                      ),
                    ),
                    child: BorderedText(
                      //TODO: install bordered_text package
                      strokeWidth: 1,
                      strokeColor: Colors.black.withOpacity(0.7),
                      strokeCap: StrokeCap.butt,
                      strokeJoin: StrokeJoin.miter,
                      child: Text(
                        'แสกน QR Code เพื่อดาวน์โหลดรูปภาพ\nไปยังมือถือของท่าน',
                        style: TextStyle(
                          fontFamily: 'JasmineUPC',
                          fontSize: 25.0,
                          color: Colors.black.withOpacity(0.7),
                          letterSpacing: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}