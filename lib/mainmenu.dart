import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'web.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'basicAuth.dart';
import 'login.dart';

class MainItem {
  final String name;
  final String icon;

  MainItem({this.name, this.icon});
}
 

class MenuMain extends StatefulWidget {
   final String mname;
  MenuMain({Key key, @required this.mname,})
      : super(key: key);

  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MenuMain> { 

  List<MainItem> _submainmenu = List<MainItem>();
  void _populateMainItem() {
    var list = <MainItem>[
      MainItem(
        name: 'Maternal Health Dashboard',
        icon: 'globe',
      ),
      MainItem(name: 'Family Planning Dashboard', icon: 'hospital'),
      MainItem(name: 'Stockout 2.0', icon: 'rupee-sign'),
      MainItem(name: 'State Ranking', icon: 'chart-pie'),
      MainItem(name: 'Admin Dashboard', icon: 'bell'),
      // MainItem(name: '', icon: 'mobile-alt'),
    ];
    setState(() {
      _submainmenu = list;
    });
  }

  @override
  void initState() {
    super.initState(); 
    _populateMainItem();
  }
 

  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('${widget.mname}'), 
        ), 
        body: Column(
          children: [
            Container(
                height: 120,
                decoration: new BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.red[200],
                    Colors.red[200].withOpacity(.7)
                  ]),
                ),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(5.0),
                    children: [
                      GestureDetector(
                        // onTap:
                        child: Column(children: [
                          Container(
                            key: Key('eld'),
                            height: 50.0,
                            width: 50.0,
                            margin: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                // new BoxShadow(
                                //     color: Color.fromARGB(100, 0, 0, 0),
                                //     blurRadius: 5.0,
                                //     offset: Offset(5.0, 5.0))
                              ],
                              border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              color: Colors.green[100],
                              // image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: NetworkImage(
                              //         "https://cdn.dribbble.com/users/1368/screenshots/1785863/icons_2x.png"))
                            ),
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.briefcaseMedical,
                              size: 25,
                            )),
                          ),
                          Container(
                              width: 60,
                              child: Text(
                                'EDL Details',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: 12),
                              ))
                        ]),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Rate Contract",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=MjI=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  color: Colors.amber[100]
                                  // color: Color(0xfff7dad9),
                                  ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.solidHandshake,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Rate Contract',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Demand Procurement Status",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=MjM=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Colors.blue[100],
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.balanceScale,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Demand Procurement Status',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: 'Common Essential Drugs',
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=MjQ=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Colors.purple[100],
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.table,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Common Essential Drugs',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Drug Expiry Details",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=MjU=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Colors.brown[100],
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.exclamationTriangle,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Drug Expiry Details',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Stock Details",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=NDM=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Colors.deepOrange[100],
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.shoppingCart,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Stock Details',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "State wise RC Expiry Details",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=Mjc=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Colors.grey[200],
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.compress,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'State wise RC Expiry Details',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Drugs Excess/Shortage",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=Mjg=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  color: Colors.indigo[100]),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.chartBar,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Drugs Excess/Shortage',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ])),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleWeb(
                                      title: "Stock Out Detail V 2.0 old",
                                      url:
                                          "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=Mjk=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1")),
                            );
                          },
                          child: Column(children: [
                            Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                color: Color(0xfff7dad9),
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.shoppingCart,
                                size: 25,
                              )),
                            ),
                            Container(
                                width: 60,
                                child: Text(
                                  'Stock Out Detail V 2.0 old',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12),
                                ))
                          ]))
                    ])),
            Expanded(
              child: Stack(
                children: <Widget>[
                  WebView(
                    key: _key,
                    initialUrl:
                        "https://cdashboard.dcservices.in/HISUtilities/dashboard/dashBoardACTION.cnt?groupId=MjE=&dashboardFor=Q0VOVFJBTCBEQVNIQk9BUkQ=&hospitalCode=998&seatId=10001&isGlobal=1",
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  isLoading
                      ? Center(
                        child: Column(
                          children:[
                          CircularProgressIndicator(),
                          Text('Loading, please wait...')
                          ]),
                          // child: CircularProgressIndicator(),
                        )
                      : Stack(),
                ],
              ),
            )
          ],
        ));
  }
}
