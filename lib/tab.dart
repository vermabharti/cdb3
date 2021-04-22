import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chartTable.dart';
import 'chartTab.dart';

class TabView extends StatelessWidget {
  @override
  // Tab Widget
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  bottom: PreferredSize(
                    preferredSize: new Size(50.0, 50.0),
                    child: Container(
                        width: 230,
                        child: TabBar(
                          unselectedLabelColor: Colors.redAccent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.redAccent,
                                Colors.orangeAccent
                              ]),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.redAccent),
                          indicatorColor: Color(0xff283643),
                          indicatorWeight: 1,
                          labelColor: Color(0xffffffff),
                          tabs: [
                            Container(
                                width: 100,
                                height: 40,
                                child: Tab(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.pie_chart),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text('Charts'),
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: 100,
                                height: 40,
                                child: Tab(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                )),
                          ],
                        )),
                  ),
                )),
            body: Container(
              margin: EdgeInsets.only(top: 10),
              child: TabBarView(children: [
                Center(child: ChartTab()),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: EdgeInsets.only(top: 30),
                        color: Color(0xffffffff),
                        child: TableDetail())),
              ]),
            )),
      ),
    );
  }
}
