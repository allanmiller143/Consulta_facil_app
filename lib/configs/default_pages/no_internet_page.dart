// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NoInternetPageController extends GetxController {
  late MyGlobalController myGlobalController;
  @override
  void onInit() {
      super.onInit();
      myGlobalController = Get.find();
  } 
  
  RxString selected = ''.obs;
}

class NoInternetPage extends StatelessWidget {
  NoInternetPage({Key? key}) : super(key: key);
  var noInternetPageController = Get.put(NoInternetPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<NoInternetPageController>(
        init: NoInternetPageController(),
        builder: (_) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
   
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imgs/semInternet.png'),
                  fit: BoxFit.cover
                )
              ),
              
            )
          );
        },
      ),
    );
  }
}
