import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/game/game.dart';
import 'package:flutter_temi_project/page/shop/shop.dart';
import 'package:flutter_temi_project/page/test/camera.dart';

// ignore: unused_import
import '../camera/cameraPage.dart';
import '../test/camera2.dart';

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
        decoration: BoxDecoration(color: Color(0xFF0E3139)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                              MaterialPageRoute(
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
                              MaterialPageRoute(builder: (context) => Game()));
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
                              MaterialPageRoute(builder: (context) => Shop()));
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
