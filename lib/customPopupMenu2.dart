import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPopupMenu2 {
  CustomPopupMenu2({this.title, this.icon});

  String title;
  IconData icon;  }

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

List<CustomPopupMenu2> choices = <CustomPopupMenu2>[
  CustomPopupMenu2(title: 'View in Icon Format', icon: Icons.home), 
  CustomPopupMenu2(title: 'Logout', icon: Icons.settings),
];

class _MainActivityState extends State<MainActivity> {
  CustomPopupMenu2 _selectedChoices = choices[0];

  void _select(CustomPopupMenu2 choice) {
    setState(() {
      _selectedChoices = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('Popup Menu Button'),
        actions: <Widget>[
          PopupMenuButton<CustomPopupMenu2>(
            elevation: 3.2,
            initialValue: choices[1],
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'This is tooltip',
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((CustomPopupMenu2 choice) {
                return PopupMenuItem<CustomPopupMenu2>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          )
        ],
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return Container(
      child: SelectedOption2(choice: _selectedChoices),
    );
  }
}

class SelectedOption2 extends StatelessWidget {
  CustomPopupMenu2 choice;

  SelectedOption2({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      choice.title,
      style: TextStyle(color: Colors.white, fontSize: 30),
    );
           
  }
}
 