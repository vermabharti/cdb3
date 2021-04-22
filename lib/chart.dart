import 'tab.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<Chart> {
  // function(value) => setState(() => drill = value);

  //Chart Widget

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Color(0xff283643),
            //   title: new Text("Charts",
            //       style: TextStyle(
            //         color: Color(0xffffffff),
            //         fontSize: 20,
            //         fontWeight: FontWeight.w400,
            //         fontFamily: 'Open Sans',
            //       )),
            //   leading: Padding(
            //       padding: EdgeInsets.only(left: 12),
            //       child: IconButton(
            //         icon: Icon(Icons.arrow_back),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //       )),
            //   actions: <Widget>[
            //     PopupMenuButton<CustomPopupMenu>(
            //         elevation: 3.2,
            //         initialValue: choices[0],
            //         onCanceled: () {
            //           print('You have not chossed anything');
            //         },
            //         tooltip: 'Select Full Size Screen',
            //         onSelected: (customPopupMenu) {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => MainActivity()),
            //           );
            //         },
            //         itemBuilder: (BuildContext context) {
            //           return choices.map((CustomPopupMenu choice) {
            //             return PopupMenuItem<CustomPopupMenu>(
            //               value: choice,
            //               child: Text(choice.title),
            //             );
            //           }).toList();
            //         })
            //   ],
            // ),
            body: Container(
          // decoration: BoxDecoration(color: Color(0xffeaebec)),

          child: Center(
            // child: Padding(
            // padding: const EdgeInsets.all(8.0),
            child: TabView(),
            // ),
          ),
        )));
  }
}
