import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'drillchartTab.dart';
import 'drillchartTable.dart';

class DrillTabView extends StatelessWidget {
  @override
  // DrillTab Widget
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xffffffff),
          // backgroundColor: Color(0xffeaebec),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              bottom: TabBar(
                indicatorColor: Color(0xff283643),
                labelColor: Color(0xff000000),
                tabs: [
                  Tab(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.pie_chart),
                        Container(
                          // margin: EdgeInsets.only(left: 8),
                          child: Text('Charts'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.table_chart),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('Tabular'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            Center(child: DrillchartTab()),
            GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  color: Color(0xffffffff),
                  child: DrillTableDetail(),
                )),
          ]),
        ),
      ),
    );
  }
}
