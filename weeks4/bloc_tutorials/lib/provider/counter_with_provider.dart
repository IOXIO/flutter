import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';

class CounterWithProvider extends StatefulWidget {
  @override
  _CounterWithProviderState createState() => _CounterWithProviderState();
}

class _CounterWithProviderState extends State<CounterWithProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter basic'),
      ),
      body: Center(
        child: Consumer<Counter>(
          builder: (context, counter, child) {
            return Text(
              'current count: ${counter.count}',
              style: TextStyle(
                fontSize: 40.0,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Counter>(context).increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
