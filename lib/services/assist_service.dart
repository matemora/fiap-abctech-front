import 'package:abctech/model/assist.dart';
import 'package:abctech/provider/assist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AssistService extends GetxService {
  late AssistProviderInterface _assistProvider;

  Future<List<Assist>> getAssists() async {
    Response response = await _assistProvider.getAssist();
    if (response.hasError) {
      return Future.error(ErrorDescription("Erro de conexão"));
    }
    try {
      List<Assist> listResult = response.body.map<Assist>((item) => Assist.fromMap(item)).toList();
      return Future.sync(() => listResult);
    } catch (e) {
      e.printInfo();
      return Future.error(ErrorDescription(e.toString()));
    }
  }

  Future<AssistService> init(AssistProviderInterface providerInterface) async {
    _assistProvider = providerInterface;
    return this;
  }
}