import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {

  LoginUiApp({Key? key}) : super(key: key);

  /*final Color _primaryColor = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');*/

  final Color _primaryColor = HexColor('#800000');
  final Color _accentColor = HexColor('#a70f01');
  // Design color
  /*final Color _primaryColor = HexColor('#FFC867');
  final Color _accentColor = HexColor('#FF3CBD');*/

  // Our Logo Color
  //Color _primaryColor= HexColor('#D44CF6');
  //Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "St.Peter's Alumni",
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(title: "St.Peter's Alumni"),
    );
  }
}


