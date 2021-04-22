import 'dart:convert';
import 'basicAuth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'linechartEDL.dart';
// import 'linechartEDL.dart';

class ChartTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChartTabState();
}

class ChartTabState extends State<ChartTab> {
  String _id;

// Get data of Graph/Table
  Future<dynamic> _fetchMainMenu() async {
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
        List<dynamic> userid = list["dataValue"];
        print('edln $userid');
        return userid;
      } else {
        throw Exception('Failed to load Menu');
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
    super.initState();
    _fetchMainMenu();
  }

  Matrix4 matrix = Matrix4.identity();
  int touchedIndex;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  List<int> showTooltips = const [];

  List<String> _locations = [
    'Column Bar Graph',
    'Line Graph',
    // 'Speciality Hospitals',
    // 'Sub Center'
  ]; // Option 2
  String _selectedLocation; // Option 2

  List<String> _month = ['Jan', 'Feb', 'March', 'April']; // Option 2
  String _monthWise;

  // UI Chart

  void _showDialog({int i}) {
    print('object $i');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return FutureBuilder<dynamic>(
              future: _fetchMainMenu(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> object = snapshot.data;
                  return Container(
                    child: new Wrap(
                      children: <Widget>[
                        new ListTile(
                            leading: new Icon(Icons.dashboard),
                            title: new Column(
                                children: object.map((e) {
                              return Text('State Name -  ${e[i]}');
                              // Text('EDL(count in nos) : 200')
                            }).toList()),
                            onTap: () => {}),
                        // new Container(
                        //   margin: EdgeInsets.only(right: 8),
                        //   child: FlatButton(
                        //     color: Colors.blueAccent,
                        //     child: new Text("District-wise"),
                        //     onPressed: () {
                        //       // print('hello world');
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(builder: (context) => EDLChart1()),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // new FlatButton(
                        //   color: Color(0xff3b8c75),
                        //   child: new Text("Drilldown 1"),
                        //   onPressed: () {
                        //     // print('hello world');
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => EDLChart2()),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return snapshot.error;
                }
                return new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(50.0)),
                      new CircularProgressIndicator(),
                    ],
                  ),
                );
              });
        });
  }

  Widget build(BuildContext context) {
    // return
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    hint:
                        Text('Select the format'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                        print('teena $_selectedLocation');
                      });
                    },
                    // onTap: ,
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  // ),
                  // Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //       border: Border.all(
                  //           color: Colors.red,
                  //           style: BorderStyle.solid,
                  //           width: 0.80),
                  //     ),
                  //     child: DropdownButton(
                  //       hint: Text('Month'), // Not necessary for Option 1
                  //       value: _monthWise,
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           _monthWise = newValue;
                  //         });
                  //       },
                  //       items: _month.map((location) {
                  //         return DropdownMenuItem(
                  //           child: new Text(location),
                  //           value: location,
                  //         );
                  //       }).toList(),
                  //     )),
                ]),
          ),
          _selectedLocation == 'Column Bar Graph' || _selectedLocation == ''
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Container(
                        width: 790,
                        height: 350,
                        // aspectRatio: 1,
                        child: Card(
                          elevation: 1,
                          // margin: EdgeInsets.only(top: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: const Color(0xff232d37),
                          child: FutureBuilder<dynamic>(
                              future: _fetchMainMenu(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  List<dynamic> object = snapshot.data;
                                  bool istouched = false;
                                  return Container(
                                      margin: EdgeInsets.all(10),
                                      child: BarChart(
                                        BarChartData(
                                            alignment:
                                                BarChartAlignment.spaceEvenly,
                                            minY: 0,
                                            maxY: 1000,
                                            axisTitleData: FlAxisTitleData(
                                                leftTitle: AxisTitle(
                                                  showTitle: true,
                                                  margin: 12,
                                                  titleText:
                                                      'Essntials Drugs Count(in no.)',
                                                  textStyle: TextStyle(
                                                      color: Color(0xffffffff)),
                                                ),
                                                bottomTitle: AxisTitle(
                                                    showTitle: true,
                                                    titleText: 'States',
                                                    margin: 12,
                                                    textStyle: TextStyle(
                                                        color: Color(
                                                            0xffffffff)))),
                                            barTouchData: BarTouchData(
                                              touchTooltipData:
                                                  BarTouchTooltipData(
                                                      tooltipBottomMargin: 8,
                                                      tooltipBgColor:
                                                          Colors.blueGrey,
                                                      getTooltipItem: (group,
                                                          groupIndex,
                                                          rod,
                                                          rodIndex) {
                                                        String weekDay;
                                                        var _list = [];
                                                        object.map((e) {
                                                          _list.add((e[0]));
                                                        }).toList();
                                                        switch (
                                                            group.x.toInt()) {
                                                          case -1:
                                                            weekDay = '';
                                                            break;
                                                          default:
                                                            weekDay = _list[
                                                                group.x
                                                                    .toInt()];
                                                        }
                                                        // value.toString();
                                                        return BarTooltipItem(
                                                            weekDay +
                                                                '\n' +
                                                                (rod.y.round())
                                                                    .toString(),
                                                            TextStyle(
                                                                color: Colors
                                                                    .yellow));
                                                      }),
                                              touchCallback:
                                                  (barTouchResponse) {
                                                setState(() {
                                                  if (barTouchResponse.spot !=
                                                          null &&
                                                      barTouchResponse
                                                              .touchInput
                                                          is! FlPanEnd &&
                                                      barTouchResponse
                                                              .touchInput
                                                          is! FlLongPressEnd) {
                                                    touchedIndex =
                                                        barTouchResponse.spot
                                                            .touchedBarGroupIndex;
                                                  } else {
                                                    touchedIndex = -1;
                                                  }
                                                });
                                              },
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              topTitles: SideTitles(
                                                showTitles: true,
                                                getTextStyles: (value) =>
                                                    const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),

                                                getTitles: (double value) {
                                                  var _list = [];
                                                  object.map((e) {
                                                    // setState(() {
                                                    _list.add((e[1]));
                                                    // print(_list);
                                                    // });
                                                  }).toList();

                                                  switch (value.toInt()) {
                                                    case -1:
                                                      return '';
                                                    // case 0:
                                                    //   return 'AP';
                                                    // case 1:
                                                    //   return 'AR';
                                                    // case
                                                    default:
                                                      return _list[
                                                          value.toInt()];
                                                  }
                                                },
                                                rotateAngle: 45,
                                                // reservedSize: -100,
                                                // interval: 200,
                                                margin: 0,
                                              ),
                                              bottomTitles: SideTitles(
                                                // checkToShowTitle: (double value) {

                                                // },
                                                rotateAngle: 60,
                                                showTitles: true,
                                                // textStyle: TextStyle(color: const Color(0xff939393), fontSize: 10),
                                                margin: 20,
                                                getTextStyles: (value) =>
                                                    const TextStyle(
                                                        color:
                                                            Color(0xffaaaaaa)),
                                                getTitles: (double value) {
                                                  var _list = [];
                                                  object.map((e) {
                                                    // setState(() {
                                                    _list.add((e[0]
                                                        .substring(0, 3)
                                                        .toUpperCase()));
                                                    // print(_list);
                                                    // });
                                                  }).toList();

                                                  switch (value.toInt()) {
                                                    case -1:
                                                      return '';
                                                    // case 0:
                                                    //   return 'AP';
                                                    // case 1:
                                                    //   return 'AR';
                                                    // case
                                                    default:
                                                      return _list[
                                                          value.toInt()];
                                                  }

                                                  // value.toString();
                                                },
                                              ),
                                              leftTitles: SideTitles(
                                                showTitles: true,
                                                // getTextStyles: TextStyle(
                                                //   color: const Color(
                                                //     0xff939393,
                                                //   ),
                                                // fontSize: 10),
                                                getTextStyles: (value) =>
                                                    const TextStyle(
                                                        color:
                                                            Color(0xffaaaaaa)),
                                                getTitles: (value) {
                                                  return '${value.toInt()}';
                                                },
                                                interval: 200,
                                                margin: 5,
                                              ),
                                            ),
                                            gridData: FlGridData(
                                              show: true,
                                              checkToShowHorizontalLine:
                                                  (value) => value % 5 == 0,
                                              getDrawingHorizontalLine:
                                                  (value) => FlLine(
                                                color: Color((0xff37434d)),
                                                strokeWidth: 1,
                                              ),
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            groupsSpace: 1,
                                            barGroups:
                                                //  showingGroups()
                                                object
                                                    .map((element) =>
                                                        // BarChartGroupData(
                                                        //   int x,
                                                        //   double y, {
                                                        //   bool isTouched = false,
                                                        //   Color barColor = Colors.white,
                                                        //   double width = 22,
                                                        //   List<int> showTooltips = const [],
                                                        // }) {
                                                        //   return BarChartGroupData(
                                                        //     x: x,
                                                        //     barRods: [
                                                        //       BarChartRodData(
                                                        //         y: isTouched ? y  : y,
                                                        //         colors: isTouched ? [Colors.yellow] : [barColor],
                                                        //         width: width,
                                                        //         backDrawRodData: BackgroundBarChartRodData(
                                                        //           show: true,
                                                        //           y: 20,
                                                        //           colors: [barBackgroundColor],
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //     showingTooltipIndicators: showTooltips,
                                                        //   );
                                                        // }).toList()
                                                        BarChartGroupData(
                                                          // barsSpace: 1,
                                                          x: object
                                                              .indexOf(element),
                                                          barRods: [
                                                            BarChartRodData(
                                                                colors: [
                                                                  Colors
                                                                      .lightBlueAccent,
                                                                  Colors
                                                                      .greenAccent
                                                                ],
                                                                y: double.parse(
                                                                    element[1]))
                                                          ],
                                                          // showingTooltipIndicators:
                                                          //     showTooltips
                                                        ))
                                                    .toList()),
                                      ));
                                } else if (snapshot.hasError) {
                                  return snapshot.error;
                                }
                                return new Center(
                                  child: new Column(
                                    children: <Widget>[
                                      new Padding(
                                          padding: new EdgeInsets.all(50.0)),
                                      new CircularProgressIndicator(),
                                    ],
                                  ),
                                );
                              }),
                          // ),
                          // ),
                        ),
                      )))
              : Container(child: LineChartEDL())
        ],
      ),
    ));
  }
}
