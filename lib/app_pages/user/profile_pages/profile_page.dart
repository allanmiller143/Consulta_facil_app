// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfilePageController extends GetxController {
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
      'campos' : ['Nome completo','CPF','Telefone','Email'],
    },
    {
      'title': 'Endereço',
      'subtitle': 'Altere seu endereço',
      'campos' : ['CEP','Estado','Cidade','Bairro','Rua','Numero'],
    },
    {
      'title': 'Senha',
      'subtitle': 'Altere sua senha',
      'campos' : [],
    },
    {
      'title': 'Apagar conta',
      'subtitle': 'Apague sua conta',
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
              if(myGlobalController.userInfo['data'] == false){
                info[i]['campos'] = ['email'];
              }
              Get.toNamed( '/edit');          
            }

            if(info[i]['title'] == 'Endereço'){
              infoSelected = info[i];
              if(myGlobalController.userInfo['data'] == false){
                showConfirmationDialog(context, 'Alerta', 'você ainda não inseriu seus dados. de endereço e contato.',);
              }
              else{
                Get.toNamed( '/edit');   
              }
            }
            

            if(info[i]['title'] == 'Senha'){
              showConfirmationDialog(context, 'Em desenvolvimento', 'Essa funcionalidade ainda está sendo desenvolvida');
            }

            if(info[i]['title'] == 'Apagar conta'){
              showConfirmationDialogFunction2(context, 'Deletar Conta', 'Apagar sua conta, resulta em apagar todos os seus dados, todas as consultas e agendamentos pendentes.\ntem certeza que deseja apagar sua conta?\ncaso sim, clique em continuar',
              ()async{
                Get.back(); // fecha o dialog
                showLoad(context);
                await deleteApi('user/${myGlobalController.userInfo['email']}');
                await FirebaseAuth.instance.currentUser?.delete();
                Get.back();
                myGlobalController.userInfo.clear();
                Get.toNamed('/');



              }
            );
            }  

           
          },
        ),
      );
    }

    return cards;
  }
}




class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  var profilePageController = Get.put(ProfilePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<ProfilePageController>(
        init: ProfilePageController(),
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
                        children: profilePageController.buildWidgets(context),
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
