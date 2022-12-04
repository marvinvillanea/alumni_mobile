import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ViewJobList extends StatefulWidget{

  ViewJobList(this.token, this.account_email, this.account_fullname, this.account_phone_no, this.user_id,this.course);

  final String token;
  final String account_email;
  final String account_fullname;
  final String account_phone_no;
  final String user_id;
  final String course;


  @override
  State<StatefulWidget> createState() {
    return _ViewJobListState();
  }
}



class _ViewJobListState extends State<ViewJobList> {
  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Find Job's",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
      ),

    );
  }


}