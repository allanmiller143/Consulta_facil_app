// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/calendar.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


class SelectDayPageController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  @override
  onInit() async {
    await initializeDateFormatting('pt_BR', null);
    super.onInit();
  }

  List<DateTime> availableDates = [
    DateTime.utc(2024, 2, 29),
    DateTime.utc(2024, 2, 30),
    DateTime.utc(2024, 3, 3),
    
  ];

  bool isDateAvailable(DateTime day) {
    return availableDates.contains(day);
  }

  void toNextScreen(context) {
    if(isDateAvailable(selectedDay.value)){
      MyGlobalQueryController myGlobalQueryController = Get.find();
      myGlobalQueryController.date = selectedDay.value;
      Get.toNamed('/hour',arguments: [selectedDay]);
    }else{
      showConfirmationDialog(context, 'Alerta', 'Por favor, selecione uma data para proceguir para a proxima etapa! ');
    }
    
  }
}

class SelectDatePage extends StatelessWidget {
  SelectDatePage({Key? key}) : super(key: key);
  var selectDayPageController = Get.put(SelectDayPageController());
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Container(
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
                        buildCalendar(selectDayPageController),
                        SizedBox(height: 20,),
                        
                        Row(
                          children: [
                            Icon(Icons.info,color: const Color.fromARGB(255, 255, 255, 255),),
                            SizedBox(width: 10,),
                            Expanded(
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  'As datas em verde são as datas disponíveis para agendar uma consulta',
                                  style: TextStyle(
                                    color: Color.fromARGB(222, 255, 255, 255),
                                    fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),

                        MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){selectDayPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),


                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
