import 'package:abctech/controller/order_controller.dart';
import 'package:abctech/provider/order_provider.dart';
import 'package:abctech/services/geolocation_service.dart';
import 'package:abctech/services/order_service.dart';
import 'package:get/get.dart';

class OrderBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(GeolocationService(), OrderService(OrderProvider())));
  }
}