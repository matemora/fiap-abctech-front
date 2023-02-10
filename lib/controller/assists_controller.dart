import 'package:abctech/model/assist.dart';
import 'package:abctech/services/assist_service.dart';
import 'package:get/get.dart';

class AssistsController extends GetxController with StateMixin<List<Assist>> {
  late AssistService _assistService;

  @override
  void onInit() {
    super.onInit();
    _assistService = Get.find<AssistService>();
  }

  void getAssistList() {
    _assistService
      .getAssists()
      .then((value) => change(value, status: RxStatus.success()))
      .onError((error, stackTrace) => change([], status: RxStatus.error(error.toString())));
  }
}