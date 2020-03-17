import 'dart:async';

import 'package:event_bus_demo/event_bus.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  StreamSubscription _themeModelscription;
  
  Color color = Color(0xfff5f5f5);

  @override
  void initState() {
    super.initState();
  _themeModelscription = eventBus.on<ThemeEvent>().listen((event) {
    setState(() {
      color = event.model == ThemeModel.light ? Color(0xfff5f5f5) : Color(0xff000000);
    });
  });
  }

  void dispose() {
    super.dispose();
    //取消订阅
    _themeModelscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor:color),
      home: HomePage(),
    );
  }
}
