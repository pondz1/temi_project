import 'package:flutter/material.dart';

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
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/red-bg-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.camera, size: 40,),
                        label: Text('Camera', style: TextStyle(fontSize: 25),),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.videogame_asset_rounded, size: 40,),
                        label: Text('Game', style: TextStyle(fontSize: 25),),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.shopping_bag_rounded, size: 40,),
                        label: Text('Shop', style: TextStyle(fontSize: 25),),
                        onPressed: () {},
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
