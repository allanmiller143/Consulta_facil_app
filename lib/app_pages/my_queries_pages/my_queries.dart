import 'package:app_clinica/controller/globalController.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueriesPageController extends GetxController {
  final List<Map<String, dynamic>> queryResults = [];



  @override
  void onInit() {
    MyGlobalController myGlobalController = Get.find();
    queryResults.addAll(myGlobalController.userQueries);
    super.onInit();
  }
  
  List<Widget> buildQueryCards(context, list) {
    List<Widget> cards = [];
    for (int i = 0; i < list.length; i++) {
      cards.add(
        MyQueryButton(
          info: list[i],
          onPressed: () {
          }
        ),
      );
    }
    return cards;
  }

}

// ignore: must_be_immutable
class QueriesPage extends StatelessWidget {
  QueriesPage({Key? key}) : super(key: key);
  var queriesPageController = Get.put(QueriesPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<QueriesPageController>(
        init: QueriesPageController(),
        builder: (_) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 77, 136, 213),
                    Color.fromARGB(255, 7, 24, 58),
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
                      padding:  EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                        children: [
                          MyHeader(),
                          SizedBox(height: 20),
                          Text(
                            'Suas Consultas',
                            style: TextStyle(
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
                      queriesPageController.queryResults.isEmpty?
                      ListView(
                        children: const [
                           Center(child: Text('Você não tem consultas',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),)),
                        ]
                      ):
                      ListView(
                        children: queriesPageController.buildQueryCards(context, queriesPageController.queryResults),
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