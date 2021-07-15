import 'dart:async';
import 'dart:math' as math;

import 'package:bordered_text/bordered_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/model/Word.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:flutter_temi_project/page/camera/cameraPreview.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  var countText = "";
  var wordText = "";
  var _isTake = false;
  Timer _timer;
  double _height = 650;
  int _wordsCount = 0;
  List<bool> _selected;

  _onSelfie() {
    int _start = 4;
    _isTake = true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          // setState(() async {
          _takePicture();
          timer.cancel();
          // });
        } else {
          setState(() {
            _start--;
            countText = _start.toString();
          });
        }
      },
    );
  }

  _takePicture() async {
    final image = await _controller.takePicture();
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) =>
              CameraPreviewImage(imagePath: image.path, imageName: image.name, word: wordText),
        )).then((value) => {
          setState(() {
            countText = "";
            _isTake = false;
          })
        });
  }

  _onChangeWord(String text, int index) {
    for (int i = 0; i < _wordsCount; i++) {
      if (i == index) {
        _selected[i] = true;
      } else {
        _selected[i] = false;
      }
    }
    setState(() {
      if (text == 'None') {
        wordText = '';
      } else {
        wordText = text;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
    _selected = List.generate(_wordsCount, (i) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Widget camera(List words) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            // decoration: BoxDecoration(color: Color(0xFF0E3139)),
            decoration: BoxDecoration(color: AppColors.background),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !_isTake
                        ? Container(
                            width: 180,
                            height: _height - 50,
                            child: ListView.builder(
                                itemCount: words.length,
                                itemBuilder: (context, index) {
                                  if (_isTake) {
                                    return null;
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            topLeft: Radius.circular(8.0),
                                          ),
                                          color:
                                              _selected[index] ? AppColors.primary : Colors.black12,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            words[index].text,
                                            style: GoogleFonts.kanit(
                                              color: _selected[index] ? Colors.white : Colors.black,
                                            ),
                                          ),
                                          onTap: () {
                                            _onChangeWord(words[index].text, index);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          )
                        : Container(),
                    Container(
                      height: _height,
                      // width: 1200,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 25.0, bottom: 1),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 0,
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: 4.0 / 3.0,
                                        child: CameraPreview(_controller),
                                      ),
                                    ),
                                  ),
                                  BorderedText(
                                    strokeWidth: 10,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      countText,
                                      style: GoogleFonts.kanit(
                                        fontSize: 100,
                                        decoration: TextDecoration.none,
                                        decorationColor: AppColors.primary,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: _height / 1.5),
                                  child: Container(
                                    width: _height + 150,
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Center(
                                          child: BorderedText(
                                            strokeWidth: 10,
                                            strokeColor: Colors.black,
                                            child: Text(
                                              wordText,
                                              style: GoogleFonts.kanit(
                                                fontSize: 30,
                                                decoration: TextDecoration.none,
                                                decorationColor: AppColors.primary,
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
                          )),
                    ),
                    !_isTake
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                      // width: 50,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _selected = List.generate(_wordsCount, (i) => false);
                                            wordText = '';
                                          });
                                        },
                                        child: Icon(
                                          Icons.refresh,
                                          size: 40,
                                        ),
                                      )),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await _initializeControllerFuture;
                                          if (!_isTake) {
                                            _onSelfie();
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Icon(
                                        Icons.camera,
                                        size: 100,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                      // width: 50,
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "เพิ่มข้อความ",
                                                  style: GoogleFonts.kanit(fontSize: 25),
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                                      child: Text('สแกนเพื่อไปยังหน้าเพิ่มข้อความ', style: GoogleFonts.kanit(),),
                                                    ),
                                                    Container(
                                                      height: 300.0, // Change as per your requirement
                                                      width: 300.0,
                                                      child: QrImage(
                                                        data: 'https://temi-668a9.web.app/camera',
                                                        version: QrVersions.auto,
                                                        gapless: false,
                                                        backgroundColor: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('ปิด',style: GoogleFonts.kanit(),),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          //
                                          // Container(
                                          //   // height: 500,
                                          //   child: Column(
                                          //     // mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       Text(
                                          //         '',
                                          //         style: GoogleFonts.kanit(fontSize: 20),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        },
                                        child: Icon(
                                          Icons.add_box_outlined,
                                          size: 40,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Take a picture')),
      body: Container(
        child: StreamBuilder(
            stream: DatabaseService().getWords(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Word> words = snapshot.data;
                _wordsCount = words.length;
                if (_selected.length == 0 || _selected.length != _wordsCount) {
                  _selected = List.generate(_wordsCount, (i) => false);
                }
                // words.insert(0, Word(time: DateTime.now(), text: 'None',selected: true));
                return camera(words);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
