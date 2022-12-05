import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobDetailsPage extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  final jobDetails;

  const JobDetailsPage({
    key,
    required this.jobDetails

  }) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _JobDetailsPageState();
  }
}



class _JobDetailsPageState extends State<JobDetailsPage> {
  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;


  var title = '';

  Future setDetaProfile() async {
    setState(() {
      title = widget.jobDetails['job_tittle'].toString();

    });
  }
  @override
  void initState() {
    super.initState();
    setDetaProfile();
    print(widget.jobDetails['job_tittle'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text(title,
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