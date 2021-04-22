import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basicAuth.dart';

class LineChartEDL extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChartEDL> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  String _id;
  // Main menu Widget
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            // padding: const EdgeInsets.all(value)
            child: Container(
              width: 500,
              height: 350,
              // aspectRatio: 1,
              child: Card(
                elevation: 1,
                // margin: EdgeInsets.only(top: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: const Color(0xff232d37),
                child: FutureBuilder<dynamic>(
                    future: _fetchMainMenu(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<dynamic> object = snapshot.data;

                        return Container(
                            margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: LineChart(LineChartData(
                                minY: 0,
                                maxY: 1000,
                                axisTitleData: FlAxisTitleData(
                                    leftTitle: AxisTitle(
                                      showTitle: true,
                                      margin: 12,
                                      titleText:
                                          'Essntials Drugs Count(in no.)',
                                      textStyle:
                                          TextStyle(color: Color(0xffffffff)),
                                    ),
                                    topTitle: AxisTitle(
                                        showTitle: true,
                                        titleText:
                                            'State Wise Essential Drugs Count',
                                        margin: 12,
                                        textStyle: TextStyle(
                                            color: Color(0xffffffff))),
                                    bottomTitle: AxisTitle(
                                        showTitle: true,
                                        titleText: 'States',
                                        margin: 12,
                                        textStyle: TextStyle(
                                            color: Color(0xffffffff)))),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: const Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: const Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    // margin:20,
                                    rotateAngle: 90,
                                    showTitles: true,
                                    reservedSize: 22,
                                    getTextStyles: (value) => const TextStyle(
                                        color: Color(0xff68737d),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                                          return _list[value.toInt()];
                                      }

                                      // value.toString();
                                    },
                                    margin: 8,
                                  ),
                                  leftTitles: SideTitles(
                                      showTitles: true,
                                      getTextStyles: (value) => const TextStyle(
                                            color: Color(0xff67727d),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                      getTitles: (value) {
                                        return '${value.toInt()}';
                                      },
                                      reservedSize: 28,
                                      margin: 12,
                                      interval: 200),
                                ),
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                        color: const Color(0xff37434d),
                                        width: 1)),
                                // minX: 0,
                                // maxX: 11,
                                // minY: 0,
                                // maxY: 6,
                                // lineBarsData:  object
                                //                                       .map((element) =>
                                //                                           // BarChartGroupData(
                                //                                           //   int x,
                                //                                           //   double y, {
                                //                                           //   bool isTouched = false,
                                //                                           //   Color barColor = Colors.white,
                                //                                           //   double width = 22,
                                //                                           //   List<int> showTooltips = const [],
                                //                                           // }) {
                                //                                           //   return BarChartGroupData(
                                //                                           //     x: x,
                                //                                           //     barRods: [
                                //                                           //       BarChartRodData(
                                //                                           //         y: isTouched ? y  : y,
                                //                                           //         colors: isTouched ? [Colors.yellow] : [barColor],
                                //                                           //         width: width,
                                //                                           //         backDrawRodData: BackgroundBarChartRodData(
                                //                                           //           show: true,
                                //                                           //           y: 20,
                                //                                           //           colors: [barBackgroundColor],
                                //                                           //         ),
                                //                                           //       ),
                                //                                           //     ],
                                //                                           //     showingTooltipIndicators: showTooltips,
                                //                                           //   );
                                //                                           // }).toList()
                                //                                           LineChartBarData(
                                //                                             // barsSpace: 1,
                                //                                             // x: object
                                //                                             //     .indexOf(element),
                                //                                             // dashArray: object.indexOf(element),
                                //                                             spots: [
                                //                                               FlSpot(
                                //                                                 double.parse(element[0].toString()),
                                //                                                 // double.parse(element[1]),
                                //                                                 // double.parse(element.toIndex()),
                                //                                                 double.parse(element[1]))
                                //                                             ],
                                //                                             // showingTooltipIndicators:
                                //                                             //     showTooltips
                                //                                           ))
                                //                                       .toList()),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, 268),
                                      FlSpot(1, 552),
                                      FlSpot(2, 391),
                                      FlSpot(3, 502),
                                      FlSpot(4, 282),
                                      FlSpot(5, 713),
                                      FlSpot(6, 690),
                                      FlSpot(7, 775),
                                      FlSpot(8, 171),
                                      FlSpot(9, 349),
                                      FlSpot(10, 658),
                                      FlSpot(11, 800),
                                      FlSpot(12, 231),
                                      FlSpot(13, 201),
                                      FlSpot(14, 425),
                                      FlSpot(15, 245),
                                      FlSpot(16, 260),
                                      FlSpot(17, 205),
                                      FlSpot(18, 603),
                                      FlSpot(19, 99),
                                      FlSpot(20, 0),
                                      FlSpot(21, 828),
                                      FlSpot(22, 208)
                                    ],
                                    isCurved: true,
                                    colors: gradientColors,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      colors: gradientColors
                                          .map(
                                              (color) => color.withOpacity(0.3))
                                          .toList(),
                                    ),
                                  ),
                                ])));
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
                    }),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: FlatButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // LineChartData mainData() {
  //   return
  // }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
