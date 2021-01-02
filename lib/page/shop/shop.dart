import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 60, right: 60),
              child: TextField(
                obscureText: false,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print("search");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: BorderedText(
                //TODO: install bordered_text package
                strokeWidth: 1,
                strokeColor: Colors.white,
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.miter,
                child: Text(
                  'Promotions ',
                  style: TextStyle(
                    fontFamily: 'JasmineUPC',
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/images/shop1.jpg", height: 260,),
                Image.asset("assets/images/shop2.jpg", height: 260,),
                Image.asset("assets/images/shop3.jpg", height: 260,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
