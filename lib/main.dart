import 'package:abctech/pages/home_bind.dart';
import 'package:abctech/pages/home_page.dart';
import 'package:abctech/provider/assist_provider.dart';
import 'package:abctech/services/assist_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

void initServices () async {
  await Get.putAsync(() => AssistService().init(AssistProvider()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/", page: () => const HomePage(), binding: HomeBind())
      ],
    );
  }
}