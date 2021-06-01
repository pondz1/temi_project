import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCirclePainter extends CustomPainter {
  List<Offset> offset;

  MyCirclePainter({@required this.offset});
  double radius =  30;


  @override
  void paint(Canvas canvas, Size size) {
    // print('test');
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    if(offset != null){
      for(int i=0;i< offset.length;i++){
        // draw shadow first
        Path oval = Path()
          ..addOval(Rect.fromCircle(center: offset[i], radius: radius));
        //canvas.drawPath(oval, shadowPaint);
        canvas.drawShadow(oval, const Color(0xFF45FC02), 2.0, true);
        // draw circle
        Paint thumbPaint = Paint()
          ..color = const Color(0xFF45FC02)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;
        canvas.drawCircle(offset[i], radius, thumbPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}