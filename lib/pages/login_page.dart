import 'dart:convert';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spc_almuni/common/theme_helper.dart';

// import 'forgot_password_page.dart';
/*
import 'registration_page.dart';
import 'widgets/header_widget.dart';*/
import 'widgets/header_widget.dart';
import 'profile_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';
import 'forgot_password_page.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  var profile_URL = 'https://spc-alumni.spc-ccs.net//api/profile_user.php';
  var dataUsers;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Welcome to SPC',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  autofocus: false,
                                  controller: user,
                                  decoration: ThemeHelper().textInputDecoration('Email', 'Enter your email'),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: pass,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  },
                                  child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    verifyUser();
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage() ));
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          const TextSpan(text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }

  Future verifyUser()async{
    print('START ');
    final uri = Uri.parse('https://spc-alumni.spc-ccs.net//api/verifyUser.php');
    final headers = {'Content-Type': 'application/json'};
    var if_exist = false;
    Map<String, dynamic> body = {'email': user.text, 'password': pass.text};
    // String jsonBody = json.encode(body);
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http.post(
          uri,
        body: json.encode(body),
      );

      int statusCode = response.statusCode;
      var responseBody = response.body;
      var jsonData = json.decode(responseBody);
      print('Response body: ${responseBody}');
      if(jsonData["code"] == "200"){
        await getProfile(jsonData["token"]);
        var accountEmail = dataUsers['email'];
        var Fullanea = dataUsers['full_name'];
        var accountContact = dataUsers['contact_no'];
        var accountUserID = dataUsers['user_id'].toString();
        var courseName = dataUsers['course'];
        var image = dataUsers['image'];
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(jsonData["token"], accountEmail,Fullanea,accountContact,accountUserID,courseName,image) ));
      } else if(responseBody == "NOT_VERIFY") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage() ));
      }
      else {
        print('Response body: ${responseBody}');
      }
    } catch (e) {
      print(e.toString());
    }
    // var response = await http.post(
    //   uri,
    //   headers: headers,
    //   body: json.encode(body),
    // );
    //

  }

  Future  getProfile(token) async  {
    print('STaring potin');
    final uri = Uri.parse(profile_URL);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'token' : token
    };
    print(json.encode(body));

    // var response = await http.post(
    //   uri,
    //   headers: headers,
    //   body: json.encode(body),
    // );

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response = await http.post(
      uri,
      body: json.encode(body),
    );
    var responseBody = response.body;
    print(responseBody);
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print(details);
    String mapString = jsonEncode(details);
    print(mapString);
    var mapObject = jsonDecode(mapString);
    print(mapObject);

    setState(() {
      dataUsers = mapObject;
      print(dataUsers['email']);
      print('End');
    });


  }

}

