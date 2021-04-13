import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

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

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
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
                      ),
                      Container(
                        height: 650,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 34.0, bottom: 20),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: CameraPreview(_controller),
                          ),
                        ),
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
                                  final image = await _controller.takePicture();
                                  print(image.path);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DisplayPictureScreen(
                                        imagePath: image?.path,
                                      ),
                                    ),
                                  );
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera_alt),
      //   onPressed: () async {
      //     try {
      //       await _initializeControllerFuture;
      //       final image = await _controller.takePicture();
      //       print(image.path);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => DisplayPictureScreen(
      //             imagePath: image?.path,
      //           ),
      //         ),
      //       );
      //     } catch (e) {
      //       print(e);
      //     }
      //   },
      // ),
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
