
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';


class PersonalEvaluation extends StatefulWidget{

/*  const PersonalEvaluation({Key? key, required this.data}  ) : super(key: key);

  final List<dynamic> data;*/

  PersonalEvaluation(this.token);

  final String token;

  @override
  State<StatefulWidget> createState() {
    return _PersonalEvaluationState();
  }
}



class _PersonalEvaluationState extends State<PersonalEvaluation> {


  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  var val = '';
  var token = '';
  List<dynamic> jsonData  = [] ;

  Future setDetails() async {
    setState(() {
      token  = widget.token;
    });
    // print('dasfdasfdasfa');
    // print(jsonData );
    // return await Future( () => jsonData  ) ;

  }



  @override
  void initState() {
    super.initState();
    setDetails();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Personal Evaluation",
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
        initialUrl: 'https://spc-alumni.spc-ccs.net/api/evulation_form.php?token='+ token,
        javascriptMode: JavascriptMode.unrestricted,
      ),

    );
    //Padding

  }


}