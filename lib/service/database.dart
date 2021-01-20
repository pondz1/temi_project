// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_temi_project/model/Goods.dart';
import 'package:flutter_temi_project/model/User.dart';

class DatabaseService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference goods = FirebaseFirestore.instance.collection('goods');

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
      return Goods(name: e['name'], image: e['image'], price: e['price'], sale: e['sale']);
    }).toList();
  }

  Stream<List<Goods>> getGoodsByName(String name) {
    return goods.orderBy('name').startAt([name]).endAt([name + '\uf8ff']).snapshots().map(_getListGoods);
  }
}
