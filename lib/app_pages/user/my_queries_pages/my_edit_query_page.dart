// ignore_for_file: unused_local_variable

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditQueriesPageController extends GetxController {

  final Map<String, dynamic> data = Get.arguments[0];

  @override
  void onInit() async{
    MyGlobalController myGlobalController = Get.find();
    super.onInit();
  }
  
  List<Widget> buildQueryCards(context) {
    List<Widget> cards = [];

      cards.add(
        MyEditQueryButton(
          title: 'Alterar Dr./Dra. ${data['Specialist']}',
          subtitle: 'Altere o médico da sua consulta, talvez outro médico não tenha a mesma disponibilidade de horário que o anterior.', 
          onPressed: () {
            MyGlobalQueryController myGlobalQueryController = Get.find();
            myGlobalQueryController.queryState = 'alterar';
            myGlobalQueryController.addEditedQuery(data);
            Get.back();
            Get.toNamed('/doctor');
          }
        ),
      );
    return cards;
  }

}
// ignore: must_be_immutable
class EditQueriesPage extends StatelessWidget {
  EditQueriesPage({Key? key}) : super(key: key);
  var editQueriesPageController = Get.put(EditQueriesPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<EditQueriesPageController>(
        init: EditQueriesPageController(),
        builder: (_) {
          return Scaffold(
            body:Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                      children: [
                        const Padding(
                          padding:   EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            children: [
                              MyHeader(),
                              SizedBox(height: 20),
                              Text(
                                'Altere Sua Consulta',
                                style:  TextStyle(
                                  fontFamily: 'Nunito-VariableFont_wght',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: 
                          ListView(
                            children: editQueriesPageController.buildQueryCards(context),
                          )
                        ),
                   
                        const SizedBox(height: 30),
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