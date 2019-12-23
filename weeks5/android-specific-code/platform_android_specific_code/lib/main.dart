import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const platform = const MethodChannel('ioxio.group/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String level;
    try {
      final result = await platform.invokeMethod('getBatteryLevel');
      level = 'Battery level at $result %';
    } on PlatformException catch (e) {
      level = 'failed to get battery level: ${e.message}';
    } on MissingPluginException catch (e) {
      level = 'missing plugin exception';
    }

    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: _getBatteryLevel,
              child: Text('get battery level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
