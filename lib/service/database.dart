// Import the firebase_core and cloud_firestore plugin
import 'dart:typed_data' show Uint8List;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_temi_project/model/Banner.dart';
import 'package:flutter_temi_project/model/Goods.dart';
import 'package:flutter_temi_project/model/User.dart';

class DatabaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference goods =
      FirebaseFirestore.instance.collection('goods');
  final CollectionReference banner =
      FirebaseFirestore.instance.collection('banner');

  List<User> _getListUser(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return User(name: doc['name'], age: doc['age']);
    }).toList();
  }

  Stream<List<User>> getUser() {
    return users.snapshots().map(_getListUser);
  }

  List<Goods> _getListGoods(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Goods(
          name: e['name'],
          image: e['image'],
          price: e['price'],
          sale: e['sale'],
          detail: e['detail'],
          location: e['location'],
          storeName: e['storeName']);
    }).toList();
  }

  Stream<List<Goods>> getGoodsByName(String name) {
    return goods
        .orderBy('name')
        .startAt([name.toLowerCase()])
        .endAt([name.toLowerCase() + '\uf8ff'])
        .snapshots()
        .map(_getListGoods);
  }

  List<BannerShop> _getListBanner(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BannerShop(
          filename: doc['filename'],
          detail: doc['detail'],
          location: doc['location'],
          storeName: doc['storeName'],
          click: doc['click'],
          id: doc.id);
    }).toList();
  }

  Stream<List<BannerShop>> getBanner() {
    return banner
        .orderBy('click', descending: true)
        .snapshots()
        .map(_getListBanner);
  }

  updateBanner(value) {
    banner.doc(value.id).set({
      'filename': value.filename,
      'detail': value.detail,
      'location': value.location,
      'storeName': value.storeName,
      'click': value.click + 1,
    });
  }

  Future<void> uploadFile(List<int> encoded, String imageName) async {
    // File file = File(filePath);
    Uint8List data = Uint8List.fromList(encoded);

    try {
      await FirebaseStorage.instance.ref('picture/$imageName').putData(data);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await FirebaseStorage.instance
        .ref('picture/$imageName')
        .getDownloadURL();
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }
}
