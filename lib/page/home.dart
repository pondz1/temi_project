import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.ac_unit_outlined),iconSize: 160, onPressed: null),
                IconButton(icon: Icon(Icons.ac_unit_outlined),iconSize: 160, onPressed: null),
                IconButton(icon: Icon(Icons.ac_unit_outlined),iconSize: 160, onPressed: null),
                CustomAnimation<double>(
                  control: CustomAnimationControl.MIRROR,
                  tween: 100.0.tweenTo(200.0),
                  duration: 2.seconds,
                  delay: 1.seconds,
                  curve: Curves.easeInOut,
                  child: Center(
                      child: IconButton(icon: Icon(Icons.ac_unit_outlined),iconSize: 160, onPressed: null)),
                  startPosition: 0.5,
                  animationStatusListener: (status) {
                    print("status updated: $status");
                  },
                  builder: (context, child, value) {
                    return Container(
                        width: value, height: value, color: Colors.blue, child: child);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LoopAnimation<double>(
                  tween: 0.0.tweenTo(10.0),
                  duration: 2.seconds,
                  curve: Curves.easeOut,
                  builder: (context, child, value) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Text("Hello!")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
