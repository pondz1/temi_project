import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:flutter_temi_project/page/game/game.dart';
import 'package:flutter_temi_project/page/shop/shop.dart';
import 'package:flutter_temi_project/page/camera/camera.dart';

// ignore: unused_import
import '../camera/Test_cameraPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraDescription cameraDescription;
  double size;
  @override
  void initState() {
    super.initState();
    initCamera();
    size = 300.0;
  }

  initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<CameraDescription> cameras = await availableCameras();
    log(cameras.toString());
    cameraDescription = cameras.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.adb,
                      size: 180,
                      color: AppColors.primary,
                    ),
                    BorderedText(
                      strokeWidth: 5,
                      strokeColor: AppColors.primary,
                      strokeCap: StrokeCap.butt,
                      strokeJoin: StrokeJoin.miter,
                      child: Text(
                        'Temi Funny',
                        style: TextStyle(
                          fontFamily: 'JasmineUPC',
                          fontSize: 80.0,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.camera,
                          size: 80,
                        ),
                        label: Text(
                          'Camera',
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      // CameraPage(),
                                      // CameraApp(),
                                      TakePictureScreen(
                                        camera: cameraDescription,
                                      )));
                        },
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.videogame_asset_rounded,
                          size: 80,
                        ),
                        label: Text(
                          'Games',
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => Game()));
                        },
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.shopping_bag_rounded,
                          size: 80,
                        ),
                        label: Text(
                          'Shops',
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => Shop()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
