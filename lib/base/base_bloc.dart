// ignore_for_file: unnecessary_type_check

import 'dart:async';

import 'package:bookstore_mobile/base/base_event.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  // loading stream here

  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();
  Sink<BaseEvent> get event => _eventStreamController.sink;

  StreamController<BaseEvent> _processEventSubject =
      BehaviorSubject<BaseEvent>();
  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;
  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Invalid event");
      }
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _processEventSubject.close();
    // close loading stream
  }
}
