import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basic/counter_basic.dart';
import 'provider/counter_with_provider.dart';
import 'provider/counter.dart';
import 'blocs/counter_with_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterWithBloc(),
      ),
      /*home: ChangeNotifierProvider(
        create: (context) => Counter(),
        child: CounterWithProvider(),
      ),*/
    );
  }
}
