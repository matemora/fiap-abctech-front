import 'dart:developer';

import 'package:abctech/model/assist.dart';
import 'package:abctech/model/order.dart';
import 'package:abctech/model/order_location.dart';
import 'package:abctech/services/geolocation_service.dart';
import 'package:abctech/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderState { creating, started, finished }

class OrderController extends GetxController with StateMixin {
  final GeolocationServiceInterface _geolocationService;
  final OrderServiceInterface _orderService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;
  final screenState = OrderState.creating.obs;
  late Order _order;

  OrderController(this._geolocationService, this._orderService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.success());
  }

  getLocation() {
    _geolocationService.getPosition().then((value) {
      log(value.toJson().toString());
    });
  }

  List<int> _assistToList() {
    return selectedAssists.map((e) => e.id).toList();
  }

  finishStartOrder() {
    switch (screenState.value) {
      case OrderState.creating:
      if(!formKey.currentState!.validate()) return;
      if(selectedAssists.isEmpty) {
        Get.snackbar("Erro", "Selecione pelo menos uma assistência técnica");
        return;
      }
        _geolocationService.getPosition().then((value) {
          OrderLocation start = OrderLocation(
            latitude: value.latitude,
            longitude: value.longitude,
            dateTime: DateTime.now(),
          );
          _order = Order(
              operatorId: int.parse(operatorIdController.text),
              assists: _assistToList(),
              start: start,
              end: null);
          screenState.value = OrderState.started;
          Get.snackbar("Sucesso", "Ordem de serviço iniciada com sucesso.");
        });
        break;
      case OrderState.started:
        change(null, status: RxStatus.loading());
        _geolocationService.getPosition().then((value) {
          _order.end = OrderLocation(
            latitude: value.latitude,
            longitude: value.longitude,
            dateTime: DateTime.now(),
          );
          _createOrder();
        });
        break;
      default:
        break;
    }
  }

  void _createOrder() {
    screenState.value = OrderState.finished;
    _orderService.createOrder(_order).then((value) {
      if (value) {
        Get.snackbar("Sucesso", "Ordem de serviço enviada com sucesso");
      }
      _clearForm();
    }).catchError((error) {
      Get.snackbar("Erro", error.toString());
      _clearForm();
    });
  }

  void _clearForm() {
    screenState.value = OrderState.creating;
    operatorIdController.text = "";
    selectedAssists.clear();
    change(null, status: RxStatus.success());
  }

  selectAssists() {
    Get.toNamed("/assists", arguments: selectedAssists);
  }
}
