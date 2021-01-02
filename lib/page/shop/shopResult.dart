import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShopResult extends StatefulWidget {
  var value;
  ShopResult({Key key, this.value}) : super(key: key);
  @override
  _ShopShopResultState createState() => _ShopShopResultState();
}

class _ShopShopResultState extends State<ShopResult> {
  var listResult = [
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMEN",
    "NIKE-WMNS ZOOM FLY 3 WOMENWOMENWOMENWOMENWOMENWOMEN"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.1),
      ),
      body: Container(
        color: Color(0xFF0E3139),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 60, right: 60),
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF707070),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("  Result: ${widget.value}", style: TextStyle(
                      fontSize: 30,
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: listResult.map((e) => itemResult(e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget itemResult (String text){
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 300.0,
      height: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF707070),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/nike.jpg",height: 150,),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            ],
          )
        ],
      ),
    );
  }
}
