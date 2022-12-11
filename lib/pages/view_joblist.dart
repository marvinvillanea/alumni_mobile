import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:spc_almuni/pages/JobDetailsPage.dart';
import 'package:spc_almuni/pages/testing.dart';

class ViewJobList extends StatefulWidget{

  /*ViewJobList(this.token, this.account_email, this.account_fullname, this.account_phone_no, this.user_id,this.course);

  final String token;
  final String account_email;
  final String account_fullname;
  final String account_phone_no;
  final String user_id;
  final String course;*/
  const ViewJobList({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<StatefulWidget> createState() {
    return _ViewJobListState();
  }
}



class _ViewJobListState extends State<ViewJobList> {
  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;


  List<dynamic> jobDetails = [] ;


  Future<List<dynamic>> getJobDetails() async {
    setState(() {
      jobDetails = widget.data;
    });
    print('dasfdasfdasfa');
    print(jobDetails);
    return await Future( () => jobDetails ) ;

  }

  @override
  void initState() {
    super.initState();
    getJobDetails();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Find Job's",
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
      body: ListView.builder(
          itemCount:   jobDetails.length,
          itemBuilder: (context,index) =>
               Card(
                 child: ListTile(
                    leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        jobDetails[index]['logo'].toString()
                    ),
                  ),
                title: Text(jobDetails[index]['job_tittle'].toString()),
                subtitle: Text(jobDetails[index]['min_salary'].toString() + ' - ' + jobDetails[index]['max_salary'].toString()),
                trailing: const Icon(Icons.arrow_forward),
                   onTap: (){
                     // Navigator.push( context, MaterialPageRoute(builder: (context) => JobDetailsPage(jobDetails : jobDetails[index])), );
                     // Navigator.push( context, MaterialPageRoute(builder: (context) => MyApp()), );
                     showModalBottomSheet<void>(
                       context: context,
                       builder: (BuildContext context) {
                         return Container(
                           padding: const EdgeInsets.all(25),
                           decoration: const BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(30),
                               topRight: Radius.circular(30),
                             )
                           ),
                           height: 550,
                           child: SingleChildScrollView(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Container(
                                     height: 0,
                                     width: 0,
                                     color: Colors.white.withOpacity(0.3),
                                   ),
                                   SizedBox(height: 5),
                                   Row(
                                     children: [
                                       Row(
                                         children: [
                                           Container(
                                             height: 50,
                                             width: 50,
                                             padding: const EdgeInsets.all(8),
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: Colors.grey.withOpacity(0.1),
                                             ),
                                             child: Image.network( jobDetails[index]['logo'].toString()),
                                           ),
                                           SizedBox(width: 10),
                                           Text(
                                             jobDetails[index]['company_name'].toString(),
                                             style: TextStyle(
                                               fontSize: 16,
                                             ),
                                           ),
                                         ],
                                       ),
                                       Row()
                                     ],
                                   ),
                                   SizedBox(height: 20),
                                   Text(
                                     jobDetails[index]['job_tittle'].toString(),
                                     textAlign: TextAlign.left,
                                     style: TextStyle(
                                       fontSize: 22,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                   SizedBox(height: 15),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.location_on_outlined,
                                             color:Colors.red,
                                           ),
                                           // SizedBox(width: 8),

                                           Text(
                                             jobDetails[index]['address'].toString(),
                                               style: TextStyle(
                                                 fontSize: 14,
                                                 color: Colors.grey,
                                               ),
                                           )
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.access_alarm_outlined,
                                             color:Colors.red,
                                           ),
                                           // SizedBox(width: 8),
                                           Text(
                                             jobDetails[index]['time_type'].toString(),
                                             style: TextStyle(
                                                 fontSize: 14,
                                                 color: Colors.grey
                                             ),
                                           )
                                         ],
                                       ),
                                       // IconText(Icons.location_on_outlined, jobDetails[index]['job_tittle'].toString()),
                                       // IconText(Icons.access_alarm_outlined, jobDetails[index]['job_tittle'].toString()),
                                     ],
                                   ),
                                   SizedBox(height: 20),
                                   Text(
                                     'Salary Range Expected',
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold
                                     ),
                                   ),
                                   SizedBox(height: 10),
                                   Text(
                                     jobDetails[index]['min_salary'].toString() + ' - ' +jobDetails[index]['max_salary'].toString(),
                                     style: TextStyle(
                                       fontSize: 14,

                                     ),
                                   ),
                                   SizedBox(height: 10),
                                   Text(
                                     'Requirement',
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold
                                     ),
                                   ),
                                   SizedBox(height: 10),
                                   Text(
                                     jobDetails[index]['job_descriptions'].toString(),
                                     style: TextStyle(
                                         fontSize: 14,

                                     ),
                                   ),
                                 ],
                               ),
                           ),
                         );
                       },
                     );
                   },
              ),
            ),
      ),
    );
  }


}