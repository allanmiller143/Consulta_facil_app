// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AController extends GetxController {
  late MyGlobalController myGlobalController;
  @override
  void onInit() {
      super.onInit();
      myGlobalController = Get.find();
  } 
  
  RxString selected = ''.obs;
}

class TryAgainPage extends StatelessWidget {
  TryAgainPage({Key? key}) : super(key: key);
  var noInternetPageController = Get.put(AController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<AController>(
        init: AController(),
        builder: (_) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
   
               decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 15, 39, 108),
                    Color.fromARGB(255, 6, 18, 42),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Center(child: Text('Tente novamente',style: TextStyle(  color: Color.fromARGB(255, 13, 37, 84),fontSize: 20,fontWeight: FontWeight.w700 ),)),
                  
                    )
                  ),
                
              ),
              
            )
          );
        },
      ),
    );
  }
}
