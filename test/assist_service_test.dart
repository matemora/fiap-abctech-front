import 'dart:convert';
import 'dart:io';

import 'package:abctech/model/assist.dart';
import 'package:abctech/provider/assist_provider.dart';
import 'package:abctech/services/assist_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'assist_service_test.mocks.dart';

@GenerateMocks([AssistProviderInterface])
void main() {
  late AssistService service;
  late MockAssistProviderInterface provider;
  setUp(() async {
    provider = MockAssistProviderInterface();
    service = await AssistService().init(provider);
    var json = File(
            "${Directory.current.path}/test/resources/assist_response.json")
        .readAsStringSync();

    when(provider.getAssist()).thenAnswer((_) async => Future.sync(
        () => Response(statusCode: HttpStatus.ok, body: jsonDecode(json))));
  });

  test('Testando a assistance service', () async {
    List<Assist> result = await service.getAssists();
    expect(result.length, 6); 
  });
}