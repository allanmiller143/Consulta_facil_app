// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


class InsertSpecialistsDaysPageController extends GetxController {
  late MyGlobalController myGlobalController;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  late List<Map<String, dynamic>> availableDates;
  
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (isDateAvailable(selectedDay) && selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
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


  bool isDateAvailable(DateTime day) {
    for (var dateMap in availableDates) {
      DateTime date = dateMap['Date'];
      if (date.year == day.year && date.month == day.month && date.day == day.day) {
        return true;
      }
    }
    return false;
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

  init() async {
    availableDates = await myGlobalController.fetchDataFromApi('Dates');
    return availableDates;
  }


}

class InsertSpecialistsDaysPage extends StatelessWidget {
  InsertSpecialistsDaysPage({Key? key}) : super(key: key);
  var insertSpecialistsDaysPageController = Get.put(InsertSpecialistsDaysPageController());
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
              future: insertSpecialistsDaysPageController.init(),
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
                            //buildCalendar(insertSpecialistsDaysPageController),
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

                            MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){insertSpecialistsDaysPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
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


