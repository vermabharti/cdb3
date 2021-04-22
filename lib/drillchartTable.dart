import 'dart:convert';
import 'package:flutter/material.dart';
import 'basicAuth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrillTableDetail extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<DrillTableDetail> {
  String _id;
  bool sort;

// 
  _fetchEDLDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _id = (prefs.getString('username') ?? "");
      final formData = jsonEncode({
        "primaryKeys": ['$_id']
      });
      Response response =
          await ioClient.post(EDL_URL, headers: headers, body: formData);
      if (response.statusCode == 200) {
        Map<String, dynamic> list = json.decode(response.body);
        List<dynamic> chartData = list["dataValue"];
        List<dynamic> chartDatareverse = chartData.reversed.toList();
        print('reverse $chartDatareverse');
        return chartData;
      } else {
        throw Exception('Failed to load Data');
      }
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xffffffff),
              title: Text("Please Check your Internet Connection",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xff000000))),
            );
          });
    }
  }

  
  

// 



  @override
  void initState() {
    sort = false;
    super.initState();
    _fetchEDLDetails();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: 
            DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Facility Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'No. of Drugs(EDL)',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        
        
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Medical College')),
            DataCell(Text('268')),
            
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Speciality Hospitals')),
            DataCell(Text('0')),
            
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('District Hospital')),
            DataCell(Text('268')),
            
          ],
        ),
         DataRow(
          cells: <DataCell>[
            DataCell(Text('Community Health Center (CHC)')),
            DataCell(Text('177')),
            
          ],
        ),
         DataRow(
          cells: <DataCell>[
            DataCell(Text('Primary Health Center (PHC)')),
            DataCell(Text('111')),
            
          ],
        ),
         DataRow(
          cells: <DataCell>[
            DataCell(Text('Sub Centre')),
            DataCell(Text('0')),
            
          ],
        ),
      ],
    )
    ));
  }
}
