import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class SettingsPage extends StatefulWidget{
 @override
 State<StatefulWidget> createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

 @override
 Widget build(BuildContext context) {
  return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Text('Settings', style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),],
        ),
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: new Container(
        color: Color.fromRGBO(18, 18, 18, 1.0),
        child: new ListView(
          children: <Widget>[
              Card (
                color: Colors.black,
                elevation: 5.0,
                child: ListTile(
                  title: Text("Username", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text(globals.username, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300))
                )
              )
          ],
        ),
      ),
    );
  }
}