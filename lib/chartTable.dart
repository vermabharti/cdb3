import 'dart:convert';
import 'package:flutter/material.dart';
import 'basicAuth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drillchart.dart';

class TableDetail extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<TableDetail> {
  String _id;
  bool sort;

  bool drilldrop = false;

  // Get table Data

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
            body: FutureBuilder<dynamic>(
                future: _fetchEDLDetails(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: new Column(
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.all(50.0)),
                          new CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  List<dynamic> chData = snapshot.data;
                  List<dynamic> reversechData = snapshot.data.reversed.toList();
                  return ListView(
                    children: <Widget>[
                      Center(
                          child: Text('State Wise Essential Drugs Count',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ))),
                      DataTable(
                        sortAscending: sort,
                        sortColumnIndex: 0,
                        columns: [
                          DataColumn(
                              label: Row(
                            children: [
                              IconButton(
                                  icon: new Icon(Icons.import_export),
                                  onPressed: () {
                                    setState(() {
                                      sort = !sort;
                                    });
                                  }),
                              Text("State",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14))
                            ],
                          )),
                          //    onSort: (columnIndex, ascending) {
                          //   setState(() {
                          //     sort = !sort;
                          //   });
                          //   if (columnIndex == 0) {
                          //                 if (ascending) {
                          //                   chData.sort((a, b) => a.name.compareTo(b.name));
                          //                 } else {
                          //                   chData.sort((a, b) => b.name.compareTo(a.name));
                          //                 }
                          //               }
                          // }),

                          DataColumn(
                              label: Text("EDL(Count In Nos.)",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)))
                        ],
                        rows: sort
                            ? reversechData
                                .map((element) => DataRow(
                                        color: MaterialStateColor.resolveWith(
                                            (element) {
                                          return Colors
                                              .grey[200]; //make tha magic!
                                        }),
                                        cells: [
                                          DataCell(Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      bool drilldrop = true;
                                                    });
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           DrillChart()),
                                                    // );
                                                    // print(
                                                    //     '${chData.indexOf(element)}');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons.assessment,
                                                      color: Colors.green,
                                                    ),
                                                  )),
                                              Text(element[0])
                                            ],
                                          )),
                                          DataCell(Text(element[1])),
                                        ]))
                                .toList()
                            : chData
                                .map((element) => DataRow(cells: [
                                      DataCell(Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DrillChart()),
                                                );
                                                // print(
                                                //     '${chData.indexOf(element)}');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 5, 0),
                                                child: Icon(
                                                  Icons.assessment,
                                                  color: Colors.green,
                                                ),
                                              )),
                                          Text(element[0])
                                        ],
                                      )),
                                      DataCell(Text(element[1])),
                                    ]))
                                .toList(),
                      ),
                    ],
                  );
                })));
  }
}
