import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/profile_widget.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSpecialistPageController extends GetxController {
  List<Map<String, dynamic>> queryResults = [];
  late MyGlobalController myGlobalController;

  @override
  void onInit() {
    myGlobalController = Get.find();
    super.onInit();
  }
  
  List<Widget> buildQueryCards(context, list) {
    List<Widget> cards = [];
      cards.add(MyProfileWidgetButton(info: const {'title': 'Inserir Médico','subtitle': 'Insira um novo médico',},onPressed: (){Get.toNamed('/insert_specialist');},),);
      cards.add(MyProfileWidgetButton(info: const {'title': 'Atualizar Médico','subtitle': 'Altere os dados de um médico ou remova do sistema',},onPressed: (){Get.toNamed('/list_specialist');},),);
    return cards;
  }
  
  init() async {
    queryResults = [{},{}];
    return queryResults;
  }

}

// ignore: must_be_immutable
class ManageSpecialistPage extends StatelessWidget {
  ManageSpecialistPage({Key? key}) : super(key: key);
  var manageSpecialistPageController = Get.put(ManageSpecialistPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<ManageSpecialistPageController>(
        init: ManageSpecialistPageController(),
        builder: (_) {
          return Scaffold( 
            body: FutureBuilder(
              future: manageSpecialistPageController.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasData) {
                    return Container(
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
                                  Text(
                                   'Gerenciar médicos',
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
                            Expanded(child:
                              ListView(
                             
                                children: manageSpecialistPageController.buildQueryCards(context, manageSpecialistPageController.queryResults),
                              )
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    );
                    
                   }else{
                    return Center(child: Text(snapshot.error.toString()));
                   }
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar a lista ${snapshot.error}');
                  } else {
                  return const LoadingWidget();
                  }
              }
            ),
          );
        },
      ),
    );
  }
}




