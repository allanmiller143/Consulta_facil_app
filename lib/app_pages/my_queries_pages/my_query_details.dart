// ignore_for_file: unused_local_variable, avoid_print

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QueriesDetailsPageController extends GetxController {
  late MyGlobalController myGlobalController;
  late Map<String,dynamic> info;
  String dateInfo =  '';



  @override
  void onInit() {
    MyGlobalController myGlobalController = Get.find();
    info = Get.arguments[0];
    dateInfo = '${info['Specialist']} , ${DateFormat.yMMMMd('pt_BR').format(info['Date'].toLocal())} ás ${DateFormat.Hm('pt_BR').format(info['Date'].toLocal())}';

    super.onInit();
  }
  
}

// ignore: must_be_immutable
class QueriesDetailsPage extends StatelessWidget {
  QueriesDetailsPage({Key? key}) : super(key: key);
  var queriesDetailsPageController = Get.put(QueriesDetailsPageController());
  int etapa = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<QueriesDetailsPageController>(
        init: QueriesDetailsPageController(),
        builder: (_) {
          return Scaffold(
            body: Container(
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
                            'Sua consulta',
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
                        children:  [
                          ListTile(
                            title: Text(queriesDetailsPageController.info['Specialty'],style: const TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                            subtitle: Text(queriesDetailsPageController.dateInfo,style: const TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 15,fontWeight: FontWeight.w600 ),),                    
                          ),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyButton(
                                label: ' Cancelar consulta',
                                 onPressed: (){
                                  showConfirmationDialogFunction2(
                                    context, 
                                    'Deseja cancelar a consulta?',
                                    'Uma vez cancelada, a consulta não pode ser alterada, você terá que agendar uma nova consulta, se for o caso', 
                                    (){
                                       print('Lógiga de cancelar a consulta');
                                    }
                                  );
                                 },
                                 width: 130,
                                 color: Colors.red,

                              ),
                              MyButton(
                                label: '  Alterar consulta',
                                onPressed: (){
                                  showConfirmationDialogFunction2(
                                    context,
                                    'Deseja Alterar os dados da consulta?',
                                    'Altere os dados da consulta e salve as alterações',
                                    (){
                                      Get.toNamed('/edit_query', arguments: [queriesDetailsPageController.info]);
                                    }
                                  );
                                },
                                width: 130,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ]
                      )
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}