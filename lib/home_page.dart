import 'package:flutter/material.dart';
import 'budget_set.dart';
import 'package:flutter/services.dart';
import 'places_page.dart';
import 'chart_page.dart';

class DashPage extends StatefulWidget {
  static String tag = 'home-page';
 @override
 _DashPageState createState() => new _DashPageState();
}

class _DashPageState extends State<DashPage>
{
  

    @override
    Widget build(BuildContext context) {
      final alucard = Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircleAvatar(
            radius: 72.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/logo.png'),
          ),
        ),
      );

      final welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ),
      );

      final orderhistory= Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
             Navigator.of(context).pushNamed(PlacesPage.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Places', style: TextStyle(color: Colors.white)),
        ),
      );


      final chart= Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ChartPage.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Analysis', style: TextStyle(color: Colors.white)),
        ),
      );


      final body = Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ]),
        ),
        child: Column(
          children: <Widget>[alucard, welcome,orderhistory,chart],
        ),
      );

      return Scaffold(
        body: body,
      );
    }
}
