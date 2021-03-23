// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
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
          storeName: doc['storeName']);
    }).toList();
  }

  Stream<List<BannerShop>> getBanner() {
    return banner.snapshots().map(_getListBanner);
  }
}
