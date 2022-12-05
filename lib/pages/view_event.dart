import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewEvents extends StatefulWidget{

  const ViewEvents({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  State<StatefulWidget> createState() {
    return _ViewEventsState();
  }
}



class _ViewEventsState extends State<ViewEvents> {
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
        title:  Text("List of Events",
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
                      jobDetails[index]['banner'].toString()
                  ),
                ),
                title: Text(jobDetails[index]['event_name'].toString()),
                subtitle: Text( 'Start Time: ' + jobDetails[index]['when'].toString() ),
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
                                        height: 100,
                                        width: 330,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: Image.network( jobDetails[index]['banner'].toString()),
                                      ),
                                    ],
                                  ),
                                  Row()
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                jobDetails[index]['event_name'].toString(),
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
                                        color:Colors.yellow,
                                      ),
                                      // SizedBox(width: 8),

                                      Text(
                                        jobDetails[index]['where'].toString(),
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
                                        color:Colors.yellow,
                                      ),
                                      // SizedBox(width: 8),
                                      Text(
                                        'Date : ' + jobDetails[index]['when'].toString(),
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
                                'Descriptions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                jobDetails[index]['desciptions'].toString(),
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