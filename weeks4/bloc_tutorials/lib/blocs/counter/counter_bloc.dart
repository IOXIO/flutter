import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';

abstract class ADataSource {
  void increment();
  void decrement();
  void multipli();
  //
}

class ARemote extends ADataSource {
  @override
  void decrement() {

  }

  @override
  void increment() {

  }

  @override
  void multipli() {
    // TODO: implement multipli
  }

}

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      // ....
    }
  }
}
