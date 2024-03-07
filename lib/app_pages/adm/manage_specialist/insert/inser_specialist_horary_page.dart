// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/app_pages/adm/manage_specialist/widgets/horary_calendar.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/widgets/hours_calendar.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/calendar.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


class InsertSpecialistHoraryPageController extends GetxController {
  late MyGlobalController myGlobalController;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  RxList<DateTime> selectedDates = <DateTime>[].obs; // salva as datas atuais
  late List<Map<String, dynamic>> availableDates;
  RxList<DateTime> selectedDatesFinal = <DateTime>[].obs; // salva todas as datas ja cadastradas

  var morningList = [];
  var afternoonList = [];

  var jsons = [
  
  ];

  



  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      if(selectedDates.contains(selectedDay)){
        selectedDates.remove(selectedDay);
      }
      else{
        selectedDates.add(focusedDay);
      }
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
      
  
    }
  }


  @override
  onInit() async {
    myGlobalController = Get.find();
    await initializeDateFormatting('pt_BR', null);
    
    super.onInit();
  }




  void toNextScreen(context) {
    
  }


  init() async {
    availableDates = await myGlobalController.fetchDataFromApi('Dates');
    return availableDates;
  }


}

class InsertSpecialistHoraryPage extends StatelessWidget {
  InsertSpecialistHoraryPage({Key? key}) : super(key: key);
  var insertSpecialistHoraryPageController = Get.put(InsertSpecialistHoraryPageController());
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
              future: insertSpecialistHoraryPageController.init(),
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
                            Expanded(
                              child: ListView(
                                children:[ 
                                  buildHoraryCalendar(insertSpecialistHoraryPageController),
                                  SizedBox(height: 20,),
                                  MyButton(label: 'Horario', onPressed: (){print(insertSpecialistHoraryPageController.selectedDates);     hihi(context,insertSpecialistHoraryPageController.selectedDates, insertSpecialistHoraryPageController);})

                                ]
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.info,color: const Color.fromARGB(255, 255, 255, 255),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    print(insertSpecialistHoraryPageController.selectedDatesFinal);
                                    print(insertSpecialistHoraryPageController.jsons);
                                  },
                                  child: Expanded(
                                    child: SizedBox(
                                      width: 50,
                                      child: Text(
                                        'Selecione as datas em seguida clique no botão "horario", para selecionar os horarios das consultas.',
                                        style: TextStyle(
                                          color: Color.fromARGB(222, 255, 255, 255),
                                          fontWeight: FontWeight.w600
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){insertSpecialistHoraryPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                            SizedBox(height: 20,),
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


