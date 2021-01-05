import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_temi_project/model/User.dart';

class DatabaseService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<User> _getListUser(QuerySnapshot snapshot){
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx2");
    return snapshot.docs.map((doc) {

      return User(name: doc['name'], age: doc['age']);
      // return User(name: '555', age: 666);
    }).toList();
  }
  Stream<List<User>> getUser() {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    return users.snapshots().map(_getListUser);
  }
}