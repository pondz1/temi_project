import 'package:flutter/material.dart';
import 'package:flutter_temi_project/model/User.dart';
import 'package:flutter_temi_project/service/database.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: DatabaseService().getUser(),
      builder: (context, snapshot){
        // print(snapshot.data);
        if (snapshot.hasData){
          print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx4");
          List<User> user = snapshot.data;
          for(var i in user){
            print(i.name);
            print(i.age);
          }
          return Container();
        } else {
          return Container();
        }
      } ,
    );
  }
}
