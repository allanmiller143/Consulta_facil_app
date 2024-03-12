// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:app_clinica/app_pages/specialist/specialist_profile_pages/Specialist_profile_page.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/insert_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SpecialistReadProfilePageController extends GetxController {
  late Map<String,dynamic>  info;
  late MyGlobalController myGlobalController;
  late SpecialistProfilePageController profilePageController;

  @override
  void onInit() {
    myGlobalController = Get.find();
    profilePageController = Get.find();
    info = profilePageController.infoSelected;



    
    super.onInit();
  }



  var specialistName = TextEditingController();
  var name = TextEditingController();
  var specialty = TextEditingController();
  var crm = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var content = TextEditingController();
  var sex = TextEditingController();
  


  List<Widget> buildWidgets(context) {
    List<Widget> cards = [];

        cards.add( buildTextField(info['campos'][0], name, context,type: 1,ativated: false));
        cards.add( buildTextField(info['campos'][1], specialistName, context,type: 1,ativated: false));
        cards.add( buildTextField(info['campos'][2], phone, context,maxLength: 11,type: 1,ativated: false));
        cards.add( buildTextField(info['campos'][3], email, context,type: 1,ativated: false));
        cards.add( buildTextField(info['campos'][4], sex, context,type: 1,ativated: false));
        cards.add( buildTextField(info['campos'][5], content, context,type: 1,ativated: false));
  
    return cards;
  }

  void change(context){
    Get.offNamed('/home');
    

 }

}


class SpecialistReadProfilePage extends StatelessWidget {
  SpecialistReadProfilePage({Key? key}) : super(key: key);
  var specialistReadProfilePageController = Get.put(SpecialistReadProfilePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SpecialistReadProfilePageController>(
        init: SpecialistReadProfilePageController(),
        builder: (_) {
          return Scaffold(
            body:Container(
              width: MediaQuery.of(context).size.width,
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: Column(
                  children: [
                    MyHeader(),
                     Text(
                      'Seus dados',
                      style: TextStyle(
                        fontSize: 26,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: specialistReadProfilePageController.buildWidgets(context),
                      )
                    )
                           
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
