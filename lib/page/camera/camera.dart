import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:bordered_text/bordered_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/model/Word.dart';
import 'package:flutter_temi_project/page/camera/cameraPreview.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';

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

  _onSelfie() {
    int _start = 4;
    _isTake = true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() async {
            final image = await _controller.takePicture();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPreviewImage(
                      imagePath: image.path,
                      imageName: image.name,
                      word: wordText),
                )).then((value) => {
                  setState(() {
                    countText = "";
                    _isTake = false;
                  })
                });
            timer.cancel();
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

  _onChangeWord(String text) {
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
            decoration: BoxDecoration(color: Color(0xFF0E3139)),
            child: Column(
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
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(words[index].text),
                                    onTap: () {
                                      _onChangeWord(words[index].text);
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                    Container(
                      height: _height,
                      // width: 1200,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(right: 34.0, bottom: 1),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Center(
                                        child: AspectRatio(
                                          aspectRatio: 3.0 / 4.0,
                                          child: CameraPreview(_controller),
                                        ),
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
                                        decorationColor: Colors.red,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: _height/1.5),
                                child:Container(
                                  width: _height+150,
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
                                              decorationColor: Colors.red,
                                              color: Color(0xfffddd00),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ],
                          )),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: SizedBox(
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await _initializeControllerFuture;
                                _onSelfie();
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
                words.insert(0, Word(time: DateTime.now(), text: 'None'));
                return camera(words);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
