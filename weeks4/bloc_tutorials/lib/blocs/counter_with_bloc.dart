import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_bloc.dart';

class CounterWithBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter basic'),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text(
              'current count: $state',
              style: TextStyle(
                fontSize: 40.0,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<CounterBloc>(context).add(CounterEvent.increment),
        child: Icon(Icons.add),
      ),
    );
  }
}
