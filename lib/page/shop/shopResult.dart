import 'package:badges/badges.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_temi_project/model/Goods.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

class ShopResult extends StatefulWidget {
  final value;

  ShopResult({Key key, this.value}) : super(key: key);

  @override
  _ShopShopResultState createState() => _ShopShopResultState();
}

class _ShopShopResultState extends State<ShopResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent.withOpacity(0.1),
      // ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF272C35)),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
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
                            "  ผลการค้นหา : ${widget.value}",
                            style: GoogleFonts.kanit(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 180),
              height: 280.0,
              child: StreamBuilder<List<Goods>>(
                stream: DatabaseService().getGoodsByName(widget.value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Goods> goods = snapshot.data;
                    return ListView.builder(
                        padding: EdgeInsets.only(top: 25, right: 30),
                        scrollDirection: Axis.horizontal,
                        itemCount: goods.length,
                        itemBuilder: (context, index) {
                          int price = (goods[index].price != null &&
                                  goods[index].price != 0
                              ? goods[index].price
                              : -1);
                          int sale = (goods[index].sale != null &&
                                  goods[index].sale != 0
                              ? goods[index].sale
                              : -1);
                          int total = price - sale;
                          int percent = (total / price * 100).floor();
                          if (percent > 100) {
                            percent = 100;
                          }
                          if (percent > 0) {
                            return Badge(
                              badgeContent: Text(
                                '$percent%',
                                style: GoogleFonts.kanit(
                                    fontSize: 25, color: Colors.white),
                              ),
                              padding: EdgeInsets.all(15),
                              position:
                                  BadgePosition.topEnd(top: -20, end: -20),
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
    var f = NumberFormat("###,###", "en_US");
    String text = (goods.name != null ? goods.name : '-');
    String image = (goods.image != null ? goods.image : '-');
    int price = (goods.price != null ? goods.price : 0);
    int sale = (goods.sale != null ? goods.sale : 0);
    int total = price - sale;
    String location = (goods.location != null ? goods.location : '-');
    String detail = (goods.detail != null ? goods.detail : '-');
    String storeName = (goods.storeName != null ? goods.storeName : '-');
    String nadText = "สินค้า : $text" +
        "\n" +
        "ราคา : $sale" +
        "\n" +
        "ชื่อร้าน : $storeName" +
        "\n" +
        "ตำแหน่ง : $location" +
        "\n" +
        "เพิ่มเติม : $detail";
    return InkWell(
      onTap: () {
        NAlertDialog(
          title: Text(
            "รายละเอียด",
            style: GoogleFonts.kanit(fontSize: 25),
          ),
          content: Text(
            nadText,
            style: GoogleFonts.kanit(fontSize: 20),
          ),
          blur: 2,
        ).show(context, transitionType: DialogTransitionType.Shrink);
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
              padding: EdgeInsets.symmetric(vertical: 8),
              height: 150,
              child: Image(
                image:
                    FirebaseImage('gs://temi-668a9.appspot.com/image/$image'),
                height: 150,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8, right: 20),
                  child: Text(
                    (text.length > 18) ? text.substring(0, 18) + '...' : text,
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
                                '\฿' + f.format(price).toString(),
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
                          '\฿' + f.format(sale).toString(),
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
