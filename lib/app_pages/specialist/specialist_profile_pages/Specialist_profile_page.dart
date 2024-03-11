// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SpecialistProfilePageController extends GetxController {
  late MyGlobalController myGlobalController;
  late Map<String,dynamic> infoSelected;

  @override
  void onInit() {
    myGlobalController = Get.find();
    super.onInit();

  }
 
  List<Map<String, dynamic>> info = [
    {
      'title': 'Dados Pessoais',
      'subtitle': 'Veja seus dados pessoais',
      'campos' : ['Nome completo','specialist','Phone','E-mail','Sex','Content',],
    },
    {
      'title': 'Horários',
      'subtitle': 'Veja seus horários',
      'campos' : [],
    },
    {
      'title': 'Senha',
      'subtitle': 'Altere sua senha',
      'campos' : [],
    },
    {
      'title': 'Configurações',
      'subtitle': 'Abrir Página de Configurações',                                 
      'campos' : [],
    }
  ];

  List<Widget> buildWidgets(context) {
    List<Widget> cards = [];

    for (int i = 0; i < info.length; i++) {
      cards.add(
        MyProfileWidgetButton(
          info: info[i],
          onPressed: () {
            if(info[i]['title'] == 'Dados Pessoais'){
              infoSelected = info[i];
              Get.toNamed('/specialist_read_profile');
                  
            }

            if(info[i]['title'] == 'Horários'){
             
            }
            

            if(info[i]['title'] == 'Senha'){
              showConfirmationDialog(context, 'Em desenvolvimento', 'Essa funcionalidade ainda está sendo desenvolvida');
            }

            if(info[i]['title'] == 'Configurações'){
              showConfirmationDialog(context, 'Em desenvolvimento', 'Essa funcionalidade ainda está sendo desenvolvida');
            }  

           
          },
        ),
      );
    }

    return cards;
  }
}




class SpecialistProfilePage extends StatelessWidget {
  SpecialistProfilePage({Key? key}) : super(key: key);
  var specialistProfilePageController = Get.put(SpecialistProfilePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SpecialistProfilePageController>(
        init: SpecialistProfilePageController(),
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
                    Expanded(
                      child: ListView(
                        children: specialistProfilePageController.buildWidgets(context),
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
