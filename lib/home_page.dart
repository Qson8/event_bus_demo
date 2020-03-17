import 'dart:async';
import 'package:flutter/material.dart';
import 'event_bus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = Color(0xfff5f5f5);
  Color textColor = Color(0xff000000);
  Color bgColor = Color(0xffffffff);
  StreamSubscription _themeModelscription;

  @override
  void initState() {
    super.initState();
    _themeModelscription = eventBus.on<ThemeEvent>().listen((event) {
      setState(() {
        color = event.model == ThemeModel.light
            ? Color(0xfff5f5f5)
            : Color(0xff000000);
        textColor = event.model == ThemeModel.light
            ? Color(0xff000000)
            : Color(0xffffffff);
        bgColor = event.model == ThemeModel.light
            ? Color(0xffffffff)
            : Color(0xff888888);
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
    return Scaffold(
      appBar: AppBar(title: Text('Qson Home'), elevation: 0),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return Container(
      color: bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                color: color,
                onPressed: () => _onTap(ThemeModel.light),
                child: Text(
                  '浅色主题',
                  style: TextStyle(fontSize: 18, color: textColor),
                )),
            Container(
              height: 30,
            ),
            FlatButton(
                color: color,
                onPressed: () => _onTap(ThemeModel.dark),
                child: Text('深色主题',
                    style: TextStyle(fontSize: 18, color: textColor))),
            Container(
              margin: EdgeInsets.only(top:30),
              child: Center(
                child: Text('by Qson',),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTap(ThemeModel model) {
    eventBus.fire(ThemeEvent(model));
  }
}
