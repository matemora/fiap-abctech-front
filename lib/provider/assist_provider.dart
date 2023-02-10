import 'package:abctech/constants.dart';
import 'package:get/get_connect.dart';

abstract class AssistProviderInterface {
  Future<Response> getAssist();
}

class AssistProvider extends GetConnect implements AssistProviderInterface {
  @override
  Future<Response> getAssist() => get("${Constants.url}/assists");
}