// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/event/add_to_cart_event.dart';
import 'package:bookstore_mobile/module/dashboard/addbook_success_event.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:rxdart/rxdart.dart';

class DashBoardBloc extends BaseBloc {
  final _titleSubject = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _score = BehaviorSubject<String>();
  final _quantity = BehaviorSubject<String>();
  final _author = BehaviorSubject<String>();
  final _image = BehaviorSubject<String>();

  Stream<String?> get titleStream => _titleSubject.stream;
  Sink<String> get titleSink => _titleSubject.sink;
  Stream<String?> get priceStream => _price.stream;
  Sink<String> get priceSink => _price.sink;
  Stream<String?> get descriptionStream => _description.stream;
  Sink<String> get descriptionSink => _description.sink;
  Stream<String?> get scoreStream => _score.stream;
  Sink<String> get scoreSink => _score.sink;
  Stream<String?> get quantityStream => _quantity.stream;
  Sink<String> get quantitySink => _quantity.sink;
  Stream<String?> get authorStream => _author.stream;
  Sink<String> get authorSink => _author.sink;
  Stream<String?> get imageStream => _image.stream;
  Sink<String> get imageSink => _image.sink;

  late OrderRepo _orderRepo;
  DashBoardBloc({required OrderRepo orderRepo}) {
    _orderRepo = orderRepo;
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddBook(event);
        break;
    }
  }

  handleAddBook(event) {
    AddToCartEvent addToCartEvent = event as AddToCartEvent;
    _orderRepo.addToBooks(addToCartEvent.bookData).then((isSuccess) {
      processEventSink.add(AddToBookSuccess());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleSubject.close();
    _author.close();
    _description.close();
    _image.close();
    _price.close();
    _quantity.close();
    _score.close();
  }
}
