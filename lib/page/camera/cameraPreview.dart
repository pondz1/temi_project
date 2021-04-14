import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraDownload.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:image/image.dart' as Img;

class CameraPreviewImage extends StatefulWidget {
  final String imagePath;
  final String imageName;
  CameraPreviewImage({Key key, this.imagePath, this.imageName})
      : super(key: key);
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewImage> {
  Img.Image _img;

  @override
  void initState() {
    super.initState();
    List<int> bytes = File(widget.imagePath).readAsBytesSync();
    _img = Img.decodeImage(bytes);
    _img = Img.flipHorizontal(_img);
    String text = 'Hello World';
    int y = (_img.height / 1.3).floor();
    // int x = (_img.width / 2).floor() - (text.length).floor();
    Img.drawStringCentered(_img, Img.arial_24, text, y: y, color: 0xff00ddfd);
  }

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
                  // color: Colors.white,
                  height: MediaQuery.of(context).size.height - 225,
                  width: MediaQuery.of(context).size.width - 190,
                  // child: Image.file(
                  //   File(widget.imagePath),
                  //   fit: BoxFit.fitHeight,
                  // ),
                  child: Image.memory(
                    Img.encodeJpg(_img),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                // print('onTap Group 8');
                await DatabaseService()
                    .uploadFile(Img.encodeJpg(_img), widget.imageName);
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
