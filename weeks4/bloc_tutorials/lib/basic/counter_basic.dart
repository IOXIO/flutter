import 'package:flutter/material.dart';

class CounterBasic extends StatefulWidget {
  @override
  _CounterBasicState createState() => _CounterBasicState();
}

class _CounterBasicState extends State<CounterBasic> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter basic'),
      ),
      body: Center(
        child: Text(
          'current count: $_count',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
