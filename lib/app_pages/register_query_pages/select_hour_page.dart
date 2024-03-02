// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/calendar.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/hour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class SelectHourPageController extends GetxController {
  Rx<DateTime> selectedHour = Get.arguments[0];
  @override
  void onInit() {
    super.onInit();
  }

 List<DateTime> availableHours = [
  DateTime.utc(2024, 3, 5, 12, 0), // 29 de fevereiro de 2024 às 12:00 PM
  DateTime.utc(2024, 3, 5, 9, 30), // 30 de fevereiro de 2024 às 9:30 AM
  DateTime.utc(2024, 3, 5, 15, 45), // 5 de março de 2024 às 3:45 PM
].obs;

  List<Widget> buildWidgets(context) {
    List<Widget> cards = [];

    for (int i = 0; i < availableHours.length; i++) {
      cards.add(
        MyHourCardButton(
          image: 'assets/imgs/agendar.png',
          label:  availableHours[i],
          onPressed: () {
            selectedHour.value = availableHours[i];
          },
          selected: selectedHour,
        ),
      );
    }

    return cards;
  }

  bool isDateAvailable(DateTime day) {
    return availableHours.contains(day);
  }


  void toNextScreen(context) {
    if(isDateAvailable(selectedHour.value)){
      showConfirmationDialogFunction(
        context,
        'Consulta agendada com sucesso',
        'textinho com os detalhes da consulta',
        (){ Get.back();Get.back();Get.back();Get.back();Get.back(); }
        
        );
      
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
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
        ),
      ),
    );
  }
}
