import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:spc_almuni/pages/JobDetailsPage.dart';
import 'package:spc_almuni/pages/testing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EditProfile extends StatefulWidget{

  EditProfile(this.token);

  final String token;


  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}



class _EditProfileState extends State<EditProfile> {

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
        title:  Text("Edit Profile",
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
      body: WebView(
        initialUrl: 'https://spc-alumni.spc-ccs.net/api/edit_profile.php?token='+ token,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }


}