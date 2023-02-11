import 'dart:developer';

import 'package:abctech/model/assist.dart';
import 'package:abctech/services/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final GeolocationService _geolocationService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;

  OrderController(this._geolocationService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  getLocation() {
    _geolocationService.getPosition().then((value) {
      log(value.toJson().toString());
    });
  }

  finishStartOrder() {
    log("teste");
  }

  selectAssists() {
    Get.toNamed("/assists", arguments: selectedAssists);
  }
}