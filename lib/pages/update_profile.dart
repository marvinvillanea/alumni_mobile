import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class UpdateProfile extends StatefulWidget{

  UpdateProfile(this.token);

  final String token;


  @override
  State<StatefulWidget> createState() {
    return _UpdateProfileState();
  }
}



class _UpdateProfileState extends State<UpdateProfile> {

  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  var token ;



  Future setDetaProfile() async {
    setState(() {
      token = widget.token;
    });
  }

  @override
  void initState() {
    super.initState();
    setDetaProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Upload Profile Image",
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