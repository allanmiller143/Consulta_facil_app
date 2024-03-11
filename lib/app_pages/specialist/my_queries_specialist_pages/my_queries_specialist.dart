import 'dart:core';
import 'package:app_clinica/app_pages/specialist/widgets/slide_calendar.dart';
import 'package:app_clinica/app_pages/specialist/widgets/specialist_card.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/profile_widget.dart';
import 'package:app_clinica/widgets/query_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SpecialistQueriesPageController extends GetxController {
  var queryResults;
  late MyGlobalController myGlobalController;
  RxString containerText = DateFormat('MMMM yyyy', 'pt_BR').format(DateTime.now()).obs;
  Rx<DateTime> selectedDay = DateTime.now().obs; 


  @override
  void onInit() {
    myGlobalController = Get.find();

    super.onInit();
  }
  
  List<Widget> buildCards(context, list) {
    List<Widget> cards = [];
      for(var item in list){
        cards.add(SpecialistCard(info: item));
      }

    return cards;
  }
  
  init() async{
    //String barra = '${selectedDay.value.toIso8601String()}-359558-PE';
    queryResults = await myGlobalController.fetchDataFromApi('Consultas');
    return queryResults;

  }

}

// ignore: must_be_immutable
class SpecialistQueriesPage extends StatelessWidget {
  SpecialistQueriesPage({Key? key}) : super(key: key);
  var specialistQueriesPageController = Get.put(SpecialistQueriesPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SpecialistQueriesPageController>(
        init: SpecialistQueriesPageController(),
        builder: (_) {
          return Scaffold(
            body: FutureBuilder(
                  future: specialistQueriesPageController.init(),
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
                              CustomCalendarSlider(containerText: specialistQueriesPageController.containerText,selectedDate: specialistQueriesPageController.selectedDay),
                            
                              const Divider(color: Colors.white,height: 5,thickness: 0.09),
                              const SizedBox(height: 5),
                               const Padding(
                                padding: EdgeInsets.fromLTRB(15,0,0,0),
                                child: Row(
                                  children: [
                                    Text('Suas consultas',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => specialistQueriesPageController.selectedDay == DateTime.now() ?
                                  ListView(
                                      children: specialistQueriesPageController.buildCards(context, specialistQueriesPageController.queryResults),
                                  )
                                  :
                                  ListView(
                                      children: specialistQueriesPageController.buildCards(context, specialistQueriesPageController.queryResults),
                                  ),
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



