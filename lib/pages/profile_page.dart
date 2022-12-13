import 'dart:convert';
import 'package:http/io_client.dart';
import 'dart:io';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:spc_almuni/pages/splash_screen.dart';
import 'package:spc_almuni/pages/widgets/header_widget.dart';

import 'edit_profile.dart';
import 'view_joblist.dart';
import 'view_event.dart';
import 'personal_evaluation.dart';
class ProfilePage extends StatefulWidget{

  ProfilePage(this.token, this.account_email, this.account_fullname, this.account_phone_no, this.user_id,this.course, this.image, this.address);

  final String token;
  final String account_email;
  final String account_fullname;
  final String account_phone_no;
  final String user_id;
  final String course;
  final String image;
  final String address;


  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}



class _ProfilePageState extends State<ProfilePage>{

  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;
  var accountEmail;
  var accountFullname;
  var accountConctactNo;
  var accountUserID;
  var token ;
  var accountCourse;
  var accountImage;
  var address;

  //LIST JOB API
  List<dynamic> jobDetails = [];
  List<dynamic> eventDetails = [];
  List<dynamic> listSurveyEvaluation = [];
  var jobListURL = 'https://spc-alumni.spc-ccs.net/api/getJobDetails.php';
  var eventListURL = 'https://spc-alumni.spc-ccs.net/api/getEvents.php';
  var listSurveyEvaluationURL = 'https://spc-alumni.spc-ccs.net/api/get_list_survey.php';

  Future setDetaProfile() async {
    setState(() {
      accountEmail = widget.account_email;
      accountConctactNo = widget.account_phone_no;
      accountFullname = widget.account_fullname;
      token = widget.token;
      accountUserID = widget.user_id;
      accountCourse = widget.course;
      accountImage = widget.image;
      address = widget.address;
    });
  }

  @override
  void initState() {
    super.initState();
    setDetaProfile();
    print(accountEmail);
    print(widget.account_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile ",
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
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only( top: 16, right: 16,),
        //     child: Stack(
        //       children: <Widget>[
        //         const Icon(Icons.notifications),
        //         Positioned(
        //           right: 0,
        //           child: Container(
        //             padding: const EdgeInsets.all(1),
        //             decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
        //             constraints: const BoxConstraints( minWidth: 12, minHeight: 12, ),
        //             child: const Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
        //           ),
        //         )
        //       ],
        //     ),
        //   )
        // ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text("St.Peter's Alumni",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Home', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen") ));
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage( 'dasfdaf', 'fdsgfsd','fdsgfsd','fdsgfsd','fdsgfsd', 'fdsgfsd','fdsgfsd') ));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>
                          ProfilePage(
                              token,
                              accountEmail,
                              accountFullname,
                              accountConctactNo,accountUserID,
                              accountCourse,
                              accountImage, address) ));
                  },
              ),
              ListTile(
                leading: Icon(Icons.manage_accounts_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Edit Profile', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen") ));
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage( 'dasfdaf', 'fdsgfsd','fdsgfsd','fdsgfsd','fdsgfsd', 'fdsgfsd','fdsgfsd') ));
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      EditProfile(
                          token
                          ) ));
                  // launchURL();

                },
              ),
              ListTile(
                leading: Icon(Icons.format_list_bulleted, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Job list', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  getJobDetails();

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewJobList( data : jobDetails) ));
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.event_note_outlined, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Events',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  getEventList();
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen")),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Personal Evaluation'
                    '',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  getListSurveyEvaluation();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalEvaluation(token)),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
            /*  ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen")),);
                },
              ),*/
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen")),);
                },
              ),
             /* ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => const SplashScreen(title: "Splash Screen")), );
                },
              ),*/
              /*Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),*/
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: const HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(5, 5),),
                      ],
                    ),
                    child: Image.network( accountImage, width:100, ),

                    // child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                  ),
                  const SizedBox(height: 20,),
                  Text(accountFullname, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Text(accountCourse, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Location"),
                                          subtitle: Text(address),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text(accountEmail),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text(accountConctactNo),
                                        ),
                                        const ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("About Me"),
                                          subtitle: Text(
                                              "This is a about me link and you can khow about me in this section."),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getJobDetails() async {
    print('STaring getJobDetails');
    final uri = Uri.parse(jobListURL);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token' : token
    };
    print(json.encode(body));

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    var responseBody = response.body;
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print(details);
    print('dsafdasfdasffgg');
    print(details);
    jobDetails = details;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewJobList(data : jobDetails) ),);
  }

  Future getEventList() async {
    print('STaring getEventList');
    final uri = Uri.parse(eventListURL);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      // 'token' : token
    };
    print(json.encode(body));
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    var responseBody = response.body;
    print(responseBody);
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print('dsafdasfdasffgg');
    print(details);
    jobDetails = details;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewEvents(data : jobDetails) ),);
  }

  Future getListSurveyEvaluation() async {
    print('STaring getListSurveyEvaluation');
    final uri = Uri.parse(listSurveyEvaluationURL);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token' : widget.token
    };
    // print(json.encode(body));
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    var responseBody = response.body;
    print(responseBody);
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print(details);
    jobDetails = details;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PersonalEvaluation(widget.token) ),);
  }
  // Future launchURL() async {
  //   var url = 'https://spc-alumni.spc-ccs.net/api/edit_profile.php?token=' + widget.token;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


}