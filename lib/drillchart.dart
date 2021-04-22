import 'package:version4/drillchartTable.dart';

import 'drillchartTab.dart';
import 'drilltab.dart';
import 'tab.dart';
import 'package:flutter/material.dart';
import 'customPopupMenu.dart';

class DrillChart extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<DrillChart> {
  bool drilldrop = false;
  List<String> _locations = [
    'Graph',
    'Tabular Format',

    // 'Speciality Hospitals',
    // 'Sub Center'
  ];

  String _selected = 'Graph'; // Option 2//

  // DrillDown Chart with graph/table
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
          child: Container(
              height: 500,
              child: Column(children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        DropdownButton(
                          hint: Text('Option'), // Not necessary for Option 1
                          value: _selected,
                          onChanged: (newValue) {
                            setState(() {
                              _selected = newValue;
                              print('teena $_selected');
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
                      ]),
                ),
                _selected == 'Graph'
                    ? SizedBox(height: 400, child: DrillchartTab())
                    : SizedBox(height: 400, child: DrillTableDetail())
              ]) // ),
              ),
        )));
  }
}
