// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/app_pages/user/register_query_pages/select_doctor_page.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/calendar.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


class SelectDayPageController extends GetxController {
  late MyGlobalController myGlobalController;
  late SelectDoctorPageController selectDoctorPageController;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  var availableDates;
  
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (isDateAvailable(selectedDay) && selectedDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
  
    }
  }

  @override
  onInit() async {
    myGlobalController = Get.find();
    selectDoctorPageController = Get.find();
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


 convertStringListToDateList( stringDates) {
  List<Map<String, dynamic>> dateList = [];

  for (String dateString in stringDates) {
    DateTime date = DateTime.parse(dateString);
    dateList.add({'Date': date});
  }

  return dateList;
}




  init() async {
 
    availableDates = await searchApi('specialist/available/${selectDoctorPageController.selectDoctorInfo['crm']}');

    availableDates = convertStringListToDateList(availableDates);

    return availableDates;
  }


}

class SelectDatePage extends StatelessWidget {
  SelectDatePage({Key? key}) : super(key: key);
  var selectDayPageController = Get.put(SelectDayPageController());
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
              future: selectDayPageController.init(),
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


