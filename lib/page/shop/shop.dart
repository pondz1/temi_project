import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_temi_project/myColors.dart';
import 'package:flutter_temi_project/page/shop/shopResult.dart';
import 'package:flutter_temi_project/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_temi_project/model/Banner.dart';
import 'package:ndialog/ndialog.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  var _textEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent.withOpacity(0.1),
      // ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 40,
                      color: AppColors.primary,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: BorderedText(
                strokeWidth: 1,
                strokeColor: AppColors.primary,
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.miter,
                child: Text(
                  'ค้นหาสินค้า',
                  style: GoogleFonts.kanit(
                    fontSize: 25.0,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 60, right: 60),
              child: TextField(
                controller: _textEdit,
                obscureText: false,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //suffixIcon: Icon(Icons.search,color: AppColors.primary,),
                  prefixIcon: Icon(Icons.search,color: AppColors.primary,),
                  fillColor: AppColors.background,
                  filled: true,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopResult(
                              value: value,
                            )),
                  ).then((value) => {_textEdit.text = ''});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: BorderedText(
                strokeWidth: 1,
                strokeColor: AppColors.primary,
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.miter,
                child: Text(
                  'Promotions ',
                  style: GoogleFonts.kanit(
                    fontSize: 25.0,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 1),
              height: 280.0,
              child: StreamBuilder<List<BannerShop>>(
                stream: DatabaseService().getBanner(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<BannerShop> banner = snapshot.data;
                    return Center(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: banner.map((e) {
                            String location = e.location;
                            String detail = e.detail;
                            String storeName = e.storeName;
                            String nadText = "ชื่อร้าน : $storeName" +
                                "\n" +
                                "ตำแหน่ง : $location" +
                                "\n" +
                                "เพิ่มเติม : $detail";
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  DatabaseService().updateBanner(e);
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
                                  ).show(context,
                                      transitionType:
                                          DialogTransitionType.Shrink);
                                },
                                child: Image(
                                  image: FirebaseImage(
                                      'gs://temi-668a9.appspot.com/banner/${e.filename}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
