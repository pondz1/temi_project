import 'package:badges/badges.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_temi_project/model/Goods.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';

class ShopResult extends StatefulWidget {
  var value;

  ShopResult({Key key, this.value}) : super(key: key);

  @override
  _ShopShopResultState createState() => _ShopShopResultState();
}

class _ShopShopResultState extends State<ShopResult> {
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
                    Text(
                      "  Result: ${widget.value}",
                      style: GoogleFonts.kanit(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              height: 280.0,
              child: StreamBuilder<List<Goods>>(
                stream: DatabaseService().getGoodsByName(widget.value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Goods> goods = snapshot.data;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: goods.length,
                        itemBuilder: (context, index) {
                          int sale = goods[index].price - goods[index].sale;
                          int percent = (sale / goods[index].price * 100).round();
                          if (percent > 0) {
                            return Badge(
                              badgeContent: Text(
                                '$percent%',
                                style: GoogleFonts.kanit(fontSize: 25, color: Colors.white),
                              ),
                              padding: EdgeInsets.all(15),
                              position: BadgePosition.topEnd(top: -20, end: -25),
                              child: itemResult(goods[index]),
                            );
                          } else {
                            return itemResult(goods[index]);
                          }
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemResult(Goods goods) {
    String text = goods.name;
    String image = goods.image;
    int price = goods.price;
    int sale = goods.sale;
    int total = price - sale;
    return InkWell(
      onTap: () {
        NAlertDialog(
          title: Text(
            "รายละเอียด",
            style: GoogleFonts.kanit(fontSize: 25),
          ),
          content: Text(
            "test",
            style: GoogleFonts.kanit(fontSize: 20),
          ),
          blur: 2,
        ).show(context, transitionType: DialogTransitionType.Bubble);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30.0),
        width: 280.0,
        // height: 250.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFF707070),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 150,
              child: Image(
                image: FirebaseImage('gs://temi-668a9.appspot.com/image/$image'),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8),
                  child: Text(
                    text,
                    style: GoogleFonts.kanit(fontSize: 20),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                Row(
                    //
                    children: [
                      (total > 0)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '\฿' + price.toString(),
                                style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '\฿' + sale.toString(),
                          style: GoogleFonts.kanit(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
