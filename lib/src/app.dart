import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controller.dart';
import 'routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController());

    return GetMaterialApp(
      title: appController.appBarTitle,
      theme: ThemeData.dark(),
      initialRoute: '/',
      getPages: routes(),
    );
  }
}
