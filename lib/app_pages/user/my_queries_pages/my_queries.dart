import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueriesPageController extends GetxController {
  var queryResults;
  late MyGlobalController myGlobalController;



  @override
  void onInit() {
    myGlobalController = Get.find();
   
    super.onInit();
  }
  
  List<Widget> buildQueryCards(context, list) {
    List<Widget> cards = [];
    for (int i = 0; i < list.length; i++) {
      cards.add(
        MyQueryButton(
          info: list[i],
          onPressed: () {
            Get.toNamed('/query_details', arguments: [list[i]]);
          }
        ),
      );
    }
    return cards;
  }
  
  init() async {
     queryResults = await searchApi('appointment/user/${myGlobalController.userInfo['email']}');

     return queryResults;
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
            body: FutureBuilder(
                  future: queriesPageController.init(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return  Container(
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
                                Padding(
                                  padding:  const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                  child: Column(
                                    children: [
                                      const MyHeader(),
                                      const SizedBox(height: 20),
                                      Text(
                                        queriesPageController.queryResults.isEmpty?   'Você ainda não possui consultas' : 'Suas consultas',
                                        style:const  TextStyle(
                                          fontFamily: 'Nunito-VariableFont_wght',
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: 
                                  queriesPageController.queryResults.isEmpty?
                                  ListView(
                                    children:  [
                                      Center(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          decoration: const BoxDecoration(
                      
                                            image: DecorationImage(image: AssetImage('assets/imgs/no_queries.png'),fit: BoxFit.cover,scale: 1.2),
                                          ),

                                        )
                                        
                                      ),
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
                        );
       
                                    
                      }else{
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      } else if (snapshot.hasError) {
                        return Text('Erro ao carregar a lista ${snapshot.error}');
                      } else {
                      return LoadingWidget();
                      }
                  }
                ),
         
          );
        },
      ),
    );
  }
}



