import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spc_almuni/common/theme_helper.dart';
import 'package:spc_almuni/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_page.dart';
import 'forgot_password_verification_page.dart';

class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  String sy_id = '';
  String course_id = '';

  var syList = [];
  var courseList =[];

  var endpoint_sy = 'http://192.168.254.136:80/api/sy.php';
  var endpoint_course = 'http://192.168.254.136:80/api/getcourse.php';
  var endpoint_register = 'http://192.168.254.136:80/api/registration_user.php';

  Future getAllSy()async{
    final uri = Uri.parse(endpoint_sy);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {};
    // String jsonBody = json.encode(body);

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    var responseBody = response.body;
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print(details);
    /*for (var k in details.values ) {
      syList.add(k);  //adding each value to the list
    }*/
    setState(() {
      syList = jsonData['details'];
    });
    print(jsonData);
    print(syList);

  }

  Future getAllCourse()async{
    final uri = Uri.parse(endpoint_course);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {};
    // String jsonBody = json.encode(body);

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    var responseBody = response.body;
    var jsonData = json.decode(responseBody);
    var details = jsonData['details'];
    print(details);
    setState(() {
      courseList = jsonData['details'];
    });
    print(jsonData);
    print(courseList);
  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController sy = TextEditingController();
  TextEditingController course = TextEditingController();

  @override
  void initState(){
    super.initState();
    getAllSy();
    getAllCourse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: const HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('First Name', 'Enter your first name'),
                            controller: firstname,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter first name";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Last Name', 'Enter your last name'),
                            controller: lastname,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter last name";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if((val!.isEmpty) || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            controller: mobile,
                            validator: (val) {
                              if((val!.isEmpty) || !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            controller: password,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              } else if(val.length < 6){
                                return "Character most be more than 6 characters";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                            child: SizedBox(
                              child:  DropdownButtonFormField<String>(
                                decoration: ThemeHelper().textInputDecoration('Course'),
                                value:  course_id.isNotEmpty ? course_id : null,
                                hint: Text('Select Course'),
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 30,
                                style: const TextStyle(color: Colors.black),
                                onChanged:  (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    course_id = value!;
                                    print(value);
                                  });
                                },
                                items: courseList.map((value) {
                                  return DropdownMenuItem(
                                    value: value['id'].toString(),
                                    child: Text(value['code'] + ' - ' + value['descriptions'] ),

                                  );
                                },).toList(),
                                validator: (value) {
                                  if((value!.isEmpty)){
                                    return "Enter course";
                                  }
                                  return null;
                                },
                              ),
                            )
                        ),
                        const SizedBox(height: 30,),
                        Container(
                            child: SizedBox(
                              child:  DropdownButtonFormField<String>(
                                decoration: ThemeHelper().textInputDecoration('School Year'),
                                value:  sy_id.isNotEmpty ? sy_id : null,
                                hint: Text('Select School Year'),
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 30,
                                style: const TextStyle(color: Colors.black),
                                onChanged:  (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    sy_id = value!;
                                    print(value);
                                  });
                                },
                                items: syList.map((value) {
                                  return DropdownMenuItem(
                                    value: value['sy_id'].toString(),
                                    child: Text(value['sy']),

                                  );
                                },).toList(),
                                validator: (value) {
                                  if((value!.isEmpty)){
                                    return "Enter a school year";
                                  }
                                  return null;
                                },
                              ),
                            )
                        ),
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                registerUser(sy_id,course_id);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future registerUser(sy_id,course_id)async{
    final uri = Uri.parse(endpoint_register);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'first_name' : firstname.text,
      'last_name' : lastname.text,
      'mobile' : mobile.text,
      'email': email.text,
      'password': password.text,
      'sy' : sy_id,
      'course' : course_id,
    };
    // String jsonBody = json.encode(body);

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    String responseBody = response.body;
    if(responseBody == "SUCCESS"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage( 'dasfdaf', 'fdsgfsd','fdsgfsd','fdsgfsd','fdsgfsd', 'fdsgfsd') ));
    } else if(responseBody == "NOT_VERIFY") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ForgotPasswordVerificationPage() ));
    }
    else {
      print('Response body: ${responseBody}');
    }
  }

}
