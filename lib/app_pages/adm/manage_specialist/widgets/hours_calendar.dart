import 'dart:ffi';

import 'package:app_clinica/app_pages/adm/manage_specialist/insert/inser_specialist_horary_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/dropDrown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Map<String, String> hoursMap = {
  '07:00': '07:00',
  '07:30': '07:30',
  '08:00': '08:00',
  '08:30': '08:30',
  '09:00': '09:00',
  '09:30': '09:30',
  '10:00': '10:00',
  '10:30': '10:30',
  '11:00': '11:00',
  '11:30': '11:30',
  '12:00': '12:00',
};

Map<String, String> hoursMapAfternoon = {
  '12:00': '12:00',
  '12:30': '12:30',
  '13:00': '13:00',
  '13:30': '13:30',
  '14:00': '14:00',
  '14:30': '14:30',
  '15:00': '15:00',
  '15:30': '15:30',
  '16:00': '16:00',
  '16:30': '16:30',
  '17:00': '17:00',
  '17:30': '17:30',
  '18:00': '18:00',
};

Map<String, String> intervalMap = {
  '00:15': '00:15',
  '00:30': '00:30',
  '00:45': '00:45',
  '01:00': '01:00',
  '01:15': '01:15',
  '01:30': '01:30',
};

var morningList = [];
var afternoonList = [];
var availabilityList = []; // Lista geral para armazenar os JSONs
var selectedBeginM = '08:00'.obs;
var selectedEndM = '12:00'.obs;
var selectedIntervalM = '00:15'.obs;

var selectedBeginA = '13:00'.obs;
var selectedEndA = '18:00'.obs;
var selectedIntervalA = '00:15'.obs;

var isAfternoonChecked = false.obs;
var isMorningChecked = false.obs;


void generateTimeSlots(context, list, InsertSpecialistHoraryPageController insertSpecialistHoraryPageController) {
  morningList.clear();
  afternoonList.clear();

  availabilityList = []; // Lista geral para armazenar os JSONs

  if (isAfternoonChecked.value || isMorningChecked.value) {
    if (isMorningChecked.value && !isAfternoonChecked.value) {
      for (var date in list) {
        var day = date.day;
        var month = date.month;
        var year = date.year;
        var startHour = int.parse(selectedBeginM.value.split(':')[0]);
        var startMinute = int.parse(selectedBeginM.value.split(':')[1]);
        var endHour = int.parse(selectedEndM.value.split(':')[0]);
        var endMinute = int.parse(selectedEndM.value.split(':')[1]);

        DateTime startTime = DateTime.utc(year, month, day, startHour, startMinute);
        DateTime endTime = DateTime.utc(year, month, day, endHour, endMinute);

        int intervalHours = 0;
        int intervalMinutes = 0;

        if (selectedIntervalM.value[0] == '0' && selectedIntervalM.value[1] == '0') {
          intervalMinutes = int.parse(selectedIntervalM.value.split(':')[1]);
        } else {
          intervalHours = int.parse(selectedIntervalM.value.split(':')[0]);
          intervalMinutes = int.parse(selectedIntervalM.value.split(':')[1]);
        }

        var availableTimes = [];
        while (startTime.isBefore(endTime)) {
          availableTimes.add(startTime.toIso8601String());
          startTime = startTime.add(Duration(hours: intervalHours, minutes: intervalMinutes));

          // Certifica-se de não ultrapassar o endTime
          if (startTime.isAfter(endTime)) {
            break;
          }

          // Se o próximo tempo for no dia seguinte, ajuste para o início do próximo dia
          if (startTime.day != day) {
            startTime = DateTime.utc(year, month, day, startHour, startMinute);
            startTime = startTime.add(Duration(hours: intervalHours, minutes: intervalMinutes));
          }
        }

        // Cria um JSON para a data e seus horários disponíveis
        var morningJson = {
          'date': date.toIso8601String(),
          'available_times': availableTimes,
        };

        // Adiciona o JSON à lista geral
        morningList.add(morningJson);
        availabilityList.add(morningJson);
      }

      // Print para teste
      print("Morning List: $morningList");
    }

    else if (isAfternoonChecked.value && !isMorningChecked.value) {
      for (var date in list) {
        var day = date.day;
        var month = date.month;
        var year = date.year;
        var startHour = int.parse(selectedBeginA.value.split(':')[0]);
        var startMinute = int.parse(selectedBeginA.value.split(':')[1]);
        var endHour = int.parse(selectedEndA.value.split(':')[0]);
        var endMinute = int.parse(selectedEndA.value.split(':')[1]);

        DateTime startTime = DateTime.utc(year, month, day, startHour, startMinute);
        DateTime endTime = DateTime.utc(year, month, day, endHour, endMinute);

        int intervalHours = 0;
        int intervalMinutes = 0;

        if (selectedIntervalA.value[0] == '0' && selectedIntervalA.value[1] == '0') {
          intervalMinutes = int.parse(selectedIntervalA.value.split(':')[1]);
        } else {
          intervalHours = int.parse(selectedIntervalA.value.split(':')[0]);
          intervalMinutes = int.parse(selectedIntervalA.value.split(':')[1]);
        }

        var availableTimes = [];
        while (startTime.isBefore(endTime)) {
          availableTimes.add(startTime.toIso8601String());
          startTime = startTime.add(Duration(hours: intervalHours, minutes: intervalMinutes));

          // Certifica-se de não ultrapassar o endTime
          if (startTime.isAfter(endTime)) {
            break;
          }

          // Se o próximo tempo for no dia seguinte, ajuste para o início do próximo dia
          if (startTime.day != day) {
            startTime = DateTime.utc(year, month, day, startHour, startMinute);
            startTime = startTime.add(Duration(hours: intervalHours, minutes: intervalMinutes));
          }
        }

        // Cria um JSON para a data e seus horários disponíveis
        var afternoonJson = {
          'date': date.toIso8601String(),
          'available_times': availableTimes,
        };

        // Adiciona o JSON à lista geral
        availabilityList.add(afternoonJson);
        availabilityList.add(afternoonJson);
      }

      // Print para teste
      print("Afternoon List: $availabilityList");
    }

  else {
    for (var date in list) {
      var day = date.day;
      var month = date.month;
      var year = date.year;

      // Manhã
      var startHourM = int.parse(selectedBeginM.value.split(':')[0]);
      var startMinuteM = int.parse(selectedBeginM.value.split(':')[1]);
      var endHourM = int.parse(selectedEndM.value.split(':')[0]);
      var endMinuteM = int.parse(selectedEndM.value.split(':')[1]);

      DateTime startTimeM = DateTime.utc(year, month, day, startHourM, startMinuteM);
      DateTime endTimeM = DateTime.utc(year, month, day, endHourM, endMinuteM);

      int intervalHoursM = 0;
      int intervalMinutesM = 0;
      var availableTimesM = [];

      if (selectedIntervalM.value[0] == '0' && selectedIntervalM.value[1] == '0') {

        intervalMinutesM = int.parse(selectedIntervalM.value.split(':')[1]);
      } else {
        intervalHoursM = int.parse(selectedIntervalM.value.split(':')[0]);
        intervalMinutesM = int.parse(selectedIntervalM.value.split(':')[1]);
      }


      while (startTimeM.isBefore(endTimeM)) {
        availableTimesM.add(startTimeM.toIso8601String());

        // Adiciona o intervalo em horas e minutos para obter o próximo tempo
        startTimeM = startTimeM.add(Duration(hours: intervalHoursM, minutes: intervalMinutesM));

        // Certifica-se de não ultrapassar o endTimeM
        if (startTimeM.isAfter(endTimeM)) {
          break;
        }
        
        // Se o próximo tempo for no dia seguinte, ajuste para o início do próximo dia
        if (startTimeM.day != day) {
          startTimeM = DateTime.utc(year, month, day, startHourM, startMinuteM);
          startTimeM = startTimeM.add(Duration(hours: intervalHoursM, minutes: intervalMinutesM));
        }
      }

      // Tarde
      var startHourA = int.parse(selectedBeginA.value.split(':')[0]);
      var startMinuteA = int.parse(selectedBeginA.value.split(':')[1]);
      var endHourA = int.parse(selectedEndA.value.split(':')[0]);
      var endMinuteA = int.parse(selectedEndA.value.split(':')[1]);

      DateTime startTimeA = DateTime.utc(year, month, day, startHourA, startMinuteA);
      DateTime endTimeA = DateTime.utc(year, month, day, endHourA, endMinuteA);

      int intervalHoursA = 0;
      int intervalMinutesA = 0;
      var availableTimesA = [];

      if (selectedIntervalA.value[0] == '0' && selectedIntervalA.value[1] == '0') {

        intervalMinutesA = int.parse(selectedIntervalA.value.split(':')[1]);
      } else {
        intervalHoursA = int.parse(selectedIntervalA.value.split(':')[0]);
        intervalMinutesA = int.parse(selectedIntervalA.value.split(':')[1]);
      }


      while (startTimeA.isBefore(endTimeA)) {
        availableTimesA.add(startTimeA.toIso8601String());

        // Adiciona o intervalo em horas e minutos para obter o próximo tempo
        startTimeA = startTimeA.add(Duration(hours: intervalHoursA, minutes: intervalMinutesA));

        // Certifica-se de não ultrapassar o endTimeM
        if (startTimeA.isAfter(endTimeA)) {
          break;
        }
        
        // Se o próximo tempo for no dia seguinte, ajuste para o início do próximo dia
        if (startTimeA.day != day) {
          startTimeA = DateTime.utc(year, month, day, startHourA, startMinuteA);
          startTimeA = startTimeA.add(Duration(hours: intervalHoursA, minutes: intervalMinutesA));
        }
      }

      // Unir as listas em uma única lista
      var availableTimes = [...availableTimesM, ...availableTimesA];

      // Cria um JSON para a data e seus horários disponíveis (manhã e tarde no mesmo JSON)
      var dayJson = {
        'date': date.toIso8601String(),
        'available_times': availableTimes,
      };

      // Adiciona o JSON à lista geral
      availabilityList.add(dayJson);
    }
  }


  showConfirmationDialogFunction(
          context, 'Sucesso', 'dias Adicionados com sucesso!',
          (){ 
            print(list);
            print(insertSpecialistHoraryPageController.selectedDates);
            for (var date in insertSpecialistHoraryPageController.selectedDates) {
              if (!insertSpecialistHoraryPageController.selectedDatesFinal.contains(date)) {
                insertSpecialistHoraryPageController.selectedDatesFinal.add(date);
              }
            }
            for (var availability in availabilityList) {
              var existingIndex = insertSpecialistHoraryPageController.jsons
                  .indexWhere((element) => element['date'] == availability['date']);

              if (existingIndex != -1) {
                // Substituir o elemento existente com o novo
                insertSpecialistHoraryPageController.jsons[existingIndex] = availability;
              } else {
                // Adicionar novo elemento se não existir
                insertSpecialistHoraryPageController.jsons.add(availability);
              }
            }
            insertSpecialistHoraryPageController.selectedDates.clear();

          Get.back();
          Get.back();

          }
  );

  } else {
    showConfirmationDialog(
        context, 'Alerta', 'Selecione o checkBox de Manhã ou Tarde para selecionar o horário de trabalho'
    );
  }

  // Print para teste
  print("Availability List: $availabilityList");
} 








void hihi(context,list,InsertSpecialistHoraryPageController insertSpecialistHoraryPageController) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 15, 39, 108),
        title: const Text(
          'Selecione o horário de trabalho para os dias selecionandos',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Nunito-VariableFont_wght',
              fontSize: 16),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Manhã',
                          style: const TextStyle(
                              fontFamily: 'Nunito-VariableFont_wght',
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Obx(
                        () => Checkbox(
                          value: isMorningChecked.value,
                          onChanged: (value) {
                            isMorningChecked.value = value!;
                         
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 17, 86, 143),
                      border:
                          Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 1),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropdownButton(
                                controller: selectedBeginM, items: hoursMap, label: 'Inicio', width: 100),
                            CustomDropdownButton(
                                controller: selectedEndM, items: hoursMap, label: 'Fim', width: 100,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        CustomDropdownButton(
                            controller: selectedIntervalM, items: intervalMap, label: 'Tempo de cada consulta', width: 100,),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Tarde',
                          style: TextStyle(
                              fontFamily: 'Nunito-VariableFont_wght',
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Obx(
                        () => Checkbox(
                          value: isAfternoonChecked.value,
                          onChanged: (value) {
                            isAfternoonChecked.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 17, 86, 143),
                      border:
                          Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 1),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropdownButton(
                                controller: selectedBeginA, items: hoursMapAfternoon, label: 'Inicio', width: 100),
                            CustomDropdownButton(
                                controller: selectedEndA, items: hoursMapAfternoon, label: 'Fim', width: 100,),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        CustomDropdownButton(
                            controller: selectedIntervalA, items: intervalMap, label: 'Tempo de cada consulta', width: 100,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          TextButton(
            onPressed: () { generateTimeSlots(context,list, insertSpecialistHoraryPageController);},
            child: const Text(
              'Continuar',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      );
    },
  );
}
