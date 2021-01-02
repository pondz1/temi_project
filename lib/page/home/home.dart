import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/game/game.dart';
import 'package:flutter_temi_project/page/shop/shop.dart';

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
    // TODO: implement initState
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
        decoration: BoxDecoration(
          color: Color(0xFF0E3139)
        ),
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
                        icon: Icon(Icons.camera, size: 80,),
                        label: Text('Camera', style: TextStyle(fontSize: 25),),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                            builder: (context) =>
                                CameraPage(),
                              // CameraExampleHome(),
                              // TakePictureScreen(camera: cameraDescription,)

                              ));
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
                        icon: Icon(Icons.videogame_asset_rounded, size: 80,),
                        label: Text('Game', style: TextStyle(fontSize: 25),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
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
                        icon: Icon(Icons.shopping_bag_rounded, size: 80,),
                        label: Text('Shop', style: TextStyle(fontSize: 25),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Shop()));
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
class Web19201 extends StatelessWidget {
  const Web19201({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E3139),
      body: Align(
        alignment: Alignment(0.0, 0.26),
        child: SizedBox(
          width: 1116.0,
          height: 1080.0,
          child: Column(
            children: <Widget>[
              Spacer(flex: 302),
              BorderedText(
                //TODO: install bordered_text package
                strokeWidth: 1,
                strokeColor: const Color(0xFF131C53),
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.miter,
                child: Text(
                  'Temi Funny',
                  style: TextStyle(
                    fontFamily: 'JasmineUPC',
                    fontSize: 250.0,
                    color: Colors.white,
                    letterSpacing: 25,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF5C1818).withOpacity(0.16),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 208),
              InkWell(
                onTap: () {
                  //TODO: onTap Group 1
                  print('onTap Group 1');
                },
                child:
// Group: Group 1
                Container(
                  alignment: Alignment(0.0, 0.02),
                  width: 435.0,
                  height: 109.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
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
                      'Click me',
                      style: TextStyle(
                        fontFamily: 'JasmineUPC',
                        fontSize: 60.0,
                        color: Colors.black,
                        letterSpacing: 6,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 177),
            ],
          ),
        ),
      ),
    );
  }
}
