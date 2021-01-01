import 'package:flutter/material.dart';
import 'package:flutter_temi_project/page/camera/cameraScreen.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
            Ink(
              decoration: ShapeDecoration(
                color: Colors.pink,
                shape: CircleBorder(),
              ),
              child: IconButton(
                color: Colors.white,
                disabledColor: Colors.white,
                iconSize: 300,
                icon: Icon(Icons.camera_alt_rounded),
                onPressed: () {
                  // TODO
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Selfie",style: TextStyle(fontSize: 130),)],
            ),
          ],
        ),
      ),
    );
  }
}
