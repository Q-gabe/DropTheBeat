import 'package:flutter/material.dart';
import 'index.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(255, 255, 255, 0.36),
    ));
    // Application root
    return MaterialApp(
      title: 'Drop the Beat!',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Index(),
      debugShowCheckedModeBanner: false,
    );
  }
}
