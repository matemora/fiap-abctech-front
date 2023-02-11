import 'package:abctech/controller/order_controller.dart';
import 'package:abctech/services/geolocation_service.dart';
import 'package:get/get.dart';

class OrderBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(GeolocationService()));
  }
}