import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = const MethodChannel('samples.flutter.dev/battery');

  Map _batteryLevel = Map<String, dynamic>();

  Future<void> _getBatteryLevel() async {
    Map batteryLevel;
    try {
      final Map result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result;
    } on PlatformException catch (e) {
      batteryLevel = Map();
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            child: Text('Get Battery Level'),
            onPressed: _getBatteryLevel,
          ),
          Text(_batteryLevel.toString()),
        ],
      ),
    );
  }
}


