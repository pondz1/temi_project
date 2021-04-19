import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CameraDownload extends StatefulWidget {
  final String imageURL;
  CameraDownload({Key key, this.imageURL}) : super(key: key);
  @override
  _CameraDownloadState createState() => _CameraDownloadState();
}

class _CameraDownloadState extends State<CameraDownload> {
  @override
  void initState() {
    super.initState();
    print(widget.imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent.withOpacity(0.1),
        // ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xFF272C35)),
          // color: Color(0xFF0E3139),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/images/qr.png",
                  //   height: 360,
                  // )
                  QrImage(
                    data: widget.imageURL,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    backgroundColor: Colors.white,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Group: Group 9
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    width: 700.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFF707070).withOpacity(0.7),
                      ),
                    ),
                    child: BorderedText(
                      strokeWidth: 1,
                      strokeColor: Colors.black.withOpacity(0.7),
                      strokeCap: StrokeCap.butt,
                      strokeJoin: StrokeJoin.miter,
                      child: Text(
                        'แสกน QR Code เพื่อดาวน์โหลดรูปภาพ\nไปยังมือถือของท่าน',
                        style: TextStyle(
                          fontFamily: 'JasmineUPC',
                          fontSize: 25.0,
                          color: Colors.black.withOpacity(0.7),
                          letterSpacing: 6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 200,
                        height: 130,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
