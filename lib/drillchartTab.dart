import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DrillchartTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrillchartTabState();
}

class DrillchartTabState extends State<DrillchartTab> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final Color thirdBarColor = const Color(0xfff9f871);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  // List<String> object = [
  //   '268', '80', '188', '0', '0', '0', '268', '80', '188', '177', '66', '111'
  // ];

  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, 268, 80, 188);
    final barGroup2 = makeGroupData(1, 0, 0, 0);
    final barGroup3 = makeGroupData(2, 268, 80, 188);
    final barGroup4 = makeGroupData(3, 177, 66, 111);
    final barGroup5 = makeGroupData(4, 111, 42, 69);
    final barGroup6 = makeGroupData(5, 0, 0, 0);
    final barGroup7 = makeGroupData(6, 268, 80, 188);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  // DrillDown ChartTab

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff2c4260),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Facility Wise Essential Drugs Count ',
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 15),
                      ),
                      const Text(
                        'State - Andhra Pradesh',
                        style:
                            TextStyle(color: Color(0xffffffff), fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        BarChartData(
                          maxY: 400,
                          minY: 0,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipPadding: const EdgeInsets.all(0),
                              tooltipBottomMargin: 8,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                return BarTooltipItem(
                                  rod.y.round().toString(),
                                  // rod.x.round().toString(),
                                  // rod.y.round().toString(),
                                  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          // touchTooltipData: BarTouchTooltipData(
                          //   tooltipBgColor: Colors.grey,
                          //   getTooltipItem: (_a, _b, _c, _d) => null,
                          // ),
                          // touchCallback: (response) {
                          //   if (response.spot == null) {
                          //     setState(() {
                          //       touchedGroupIndex = -1;
                          //       showingBarGroups = List.of(rawBarGroups);
                          //     });
                          //     return;
                          //   }

                          //   touchedGroupIndex = response.spot.touchedBarGroupIndex;

                          //   setState(() {
                          //     if (response.touchInput is FlLongPressEnd ||
                          //         response.touchInput is FlPanEnd) {
                          //       touchedGroupIndex = -1;
                          //       showingBarGroups = List.of(rawBarGroups);
                          //     } else {
                          //       showingBarGroups = List.of(rawBarGroups);
                          //       if (touchedGroupIndex != -1) {
                          //         double sum = 0;
                          //         for (BarChartRodData rod
                          //             in showingBarGroups[touchedGroupIndex].barRods) {
                          //           sum += rod.y;
                          //         }
                          //         final avg =
                          //             sum / showingBarGroups[touchedGroupIndex].barRods.length;

                          //         showingBarGroups[touchedGroupIndex] =
                          //             showingBarGroups[touchedGroupIndex].copyWith(
                          //           barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                          //             return rod.copyWith(y: avg);
                          //           }).toList(),
                          //         );
                          //       }
                          //     }
                          //   });
                          // }
                          // ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 20,
                              rotateAngle: 280,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Medical College';
                                  case 1:
                                    return 'Speciality Hospital';
                                  case 2:
                                    return 'District Hospital';
                                  case 3:
                                    return 'Community Health..';
                                  case 4:
                                    return 'Primary Health..';
                                  case 5:
                                    return 'Sub Center';
                                  case 6:
                                    return 'Urban Primary Health..';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 32,
                              interval: 200,
                              reservedSize: 14,
                              getTitles: (value) {
                                return '${value.toInt()}';
                              },
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y3,
        colors: [thirdBarColor],
        width: width,
      ),
    ], showingTooltipIndicators: [
      0,
      0,
      0,
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
