import 'package:abctech/constants.dart';
import 'package:abctech/model/order.dart';
import 'package:get/get_connect.dart';

abstract class OrderProviderInterface {
    Future<Response> postOrder(Order order);
}

class OrderProvider extends GetConnect implements OrderProviderInterface {
    @override
    Future<Response> postOrder(Order order) => post('${Constants.url}/order', order.toMap());
}