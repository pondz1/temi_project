import 'dart:io';
import 'dart:typed_data';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraDownload.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as Img;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:screenshot/screenshot.dart';

import '../../myColors.dart';

final RoundedLoadingButtonController _btnController =
    new RoundedLoadingButtonController();

class CameraPreviewImage extends StatefulWidget {
  final String imagePath;
  final String imageName;
  final String word;

  CameraPreviewImage({Key key, this.imagePath, this.imageName, this.word})
      : super(key: key);

  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreviewImage> {
  Img.Image _img;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    List<int> bytes = File(widget.imagePath).readAsBytesSync();
    _img = Img.decodeImage(bytes);
    _img = Img.flipHorizontal(_img);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height - 225;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.background,),
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
                      color: AppColors.primary,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: _height,
                    // width: double.parse(_img.height.toString()),
                    child: Image.memory(
                      Img.encodeJpg(_img),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: _height / 1.5),
                      child: Container(
                        width: _height + 100,
                        // height: _height,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Center(
                              child: BorderedText(
                                strokeWidth: 10,
                                strokeColor: Colors.black,
                                child: Text(
                                  widget.word,
                                  style: GoogleFonts.kanit(
                                    fontSize: 30,
                                    decoration: TextDecoration.none,
                                    decorationColor: Colors.red,
                                    color: Color(0xfffddd00),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundedLoadingButton(
                color: AppColors.primary,
                height: 80,
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'ดาวน์โหลด',
                    style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                controller: _btnController,
                onPressed: () async {
                  // print('onTap Group 8');
                  await screenshotController
                      .capture(delay: Duration(milliseconds: 10), pixelRatio: 1)
                      .then((Uint8List image) async {
                    await DatabaseService().uploadFile(image, widget.imageName);
                    var url =
                        await DatabaseService().downloadURL(widget.imageName);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CameraDownload(
                          imageURL: url,
                        ),
                      ),
                    ).then((value) => {setState(() {})});
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
