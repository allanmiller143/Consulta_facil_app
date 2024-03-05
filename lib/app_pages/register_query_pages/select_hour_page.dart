// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_overrides
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/hour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class SelectHourPageController extends GetxController {
  Rx<DateTime> selectedHour = Get.arguments[0];
  late MyGlobalQueryController myGlobalQueryController;
  late MyGlobalController myGlobalController;
  late List<Map<String, dynamic>> availableHours;

  @override
  void onInit() { 
    myGlobalQueryController = Get.find();
    myGlobalController = Get.find();

    if (myGlobalQueryController.queryState == 'alterar') {
      selectedHour.value = myGlobalQueryController.date;

      availableHours.add({
        'Hour': DateTime.utc(
          myGlobalQueryController.editedQuery['Date'].year,
          myGlobalQueryController.editedQuery['Date'].month,
          myGlobalQueryController.editedQuery['Date'].day,
          myGlobalQueryController.editedQuery['Date'].hour,
          myGlobalQueryController.editedQuery['Date'].minute,
        ),
      });
    }
    super.onInit();

  }

  


  List<Widget> buildWidgets(context) {
    List<Widget> cards = [];

    for (int i = 0; i < availableHours.length; i++) {
      cards.add(
        MyHourCardButton(
          image: 'assets/imgs/agendar.png',
          label:  availableHours[i]['Hour'],
          onPressed: () {
            selectedHour.value = availableHours[i]['Hour'];
          },
          selected: selectedHour,
        ),
      );
    }

    return cards;
  }



  bool isDateAvailable(DateTime day) {
    for (var dateMap in availableHours) {
      DateTime date = dateMap['Hour'];
      if (date.year == day.year && date.month == day.month && date.day == day.day) {
        return true;
      }
    }
    return false;
  }

  init() async {
    availableHours = await myGlobalController.fetchDataFromApi('Hours');
    return availableHours;
  }


  void toNextScreen(context) {
    if(isDateAvailable(selectedHour.value)){
      MyGlobalQueryController myGlobalQueryController = Get.find();
      if(myGlobalQueryController.queryState == 'inserir'){      
      showConfirmationDialogFunction(
        context,
        'Consulta agendada com sucesso',
        'textinho com os detalhes da consulta',
        (){ 
          
          myGlobalQueryController.date = selectedHour.value; 
          myGlobalQueryController.addQuery();
          Get.back();Get.back();Get.back();Get.back();Get.back();
          }
        );
      }else{
        showConfirmationDialogFunction(
        context,
        'Consulta alterada com sucesso!',
        'textinho com os novos detalhes da consulta',
        (){ 
          MyGlobalQueryController myGlobalQueryController = Get.find();
          myGlobalQueryController.date = selectedHour.value; 
          myGlobalQueryController.editQuery('asdf');
          Get.back();Get.back();Get.back();Get.back();Get.back();Get.back();Get.back();
          }
        );

      }

      
    }else{
      showConfirmationDialog(context, 'Alerta', 'Por favor, selecione um horário disponível',);
    }
  }
}

class SelectHourPage extends StatelessWidget {
  SelectHourPage({Key? key}) : super(key: key);
  var selectHourPageController = Get.put(SelectHourPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
              future: selectHourPageController.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasData) {
                    return 
                    Container(
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
                            SizedBox(height: 20),

                            Text('Selecione um horário do dia:',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                            Text(DateFormat.yMMMMd('pt_BR').format(Get.arguments[0].value.toLocal()),style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),

                            SizedBox(height:5),
                            Expanded(
                              child: ListView(
                                children: selectHourPageController.buildWidgets(context),
                              ),
                            ),
                            SizedBox(height: 20),
                            MyButton(
                              label: 'continuar',
                              borderRadius: BorderRadius.circular(50),
                              onPressed: () {
                                selectHourPageController.toNextScreen(context);
                              },
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontColor: Color.fromARGB(255, 61, 102, 159),
                            ),
                            SizedBox(height: 20),
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
        
      ),
    );
  }
}



