import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraDownload.dart';
import 'package:flutter_temi_project/service/database.dart';

class CameraPreviewImage extends StatefulWidget {
  final String imagePath;
  final String imageName;
  CameraPreviewImage({Key key, this.imagePath, this.imageName})
      : super(key: key);
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent.withOpacity(0.1),
      // ),
      body: Container(
        color: Color(0xFF0E3139),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - 225,
                  width: MediaQuery.of(context).size.width - 190,
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                // print('onTap Group 8');
                await DatabaseService()
                    .uploadFile(widget.imagePath, widget.imageName);
                var url = await DatabaseService().downloadURL(widget.imageName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraDownload(
                              imageURL: url,
                            ))).then((value) => {setState(() {})});
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
