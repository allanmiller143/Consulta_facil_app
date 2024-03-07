import 'package:app_clinica/app_pages/adm/manage_specialist/insert/inser_specialist_horary_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:table_calendar/table_calendar.dart';

Widget buildHoraryCalendar(InsertSpecialistHoraryPageController pageController,context) => Obx(
  () => Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    child: Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TableCalendar(
        rowHeight: 40,
        firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 14),
        focusedDay: pageController.focusedDay.value,
        daysOfWeekHeight: 40,
        selectedDayPredicate: (day) {
          return pageController.selectedDay.value.isAfter(DateTime.now().subtract(const Duration(days: 1))) && isSameDay(pageController.selectedDay.value, day);
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(color: Colors.white),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 6, 26, 54),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
        ),
        locale: 'pt_BR',
        calendarStyle: CalendarStyle(
          selectedTextStyle: const TextStyle(color: Colors.black),
          selectedDecoration: BoxDecoration(
            color: pageController.selectedDates.contains(pageController.focusedDay.value) ? Colors.green : const Color.fromARGB(184, 255, 255, 255),
            border: pageController.selectedDatesFinal.contains(pageController.focusedDay.value) ? Border.all(color:Colors.red, width: 2) : null,
            shape: BoxShape.circle
          ),
          isTodayHighlighted: false
        ),
        onDayLongPressed: (selectedDay, focusedDay) {
          String content = '';
          bool manhaEncontrada = false;
          bool tardeEncontrada = false;

          if (pageController.selectedDatesFinal.contains(selectedDay)) {
            for (var json in pageController.jsons) {
              if (json['date'] == selectedDay.toIso8601String()) {
                for (var item in json['available_times']) {
                  // Converta a string para DateTime antes de acessar as propriedades hour e minute
                  DateTime dateTimeItem = DateTime.parse(item);

                  // Use padLeft para garantir dois dígitos nos minutos
                  String minutes = dateTimeItem.minute.toString().padLeft(2, '0');
                  
                  if (dateTimeItem.hour < 12 && !manhaEncontrada) {
                    content += 'Manhã:\n';
                    manhaEncontrada = true;
                  } else if (dateTimeItem.hour >= 12 && !tardeEncontrada) {
                    content += 'Tarde:\n';
                    tardeEncontrada = true;
                  }

                  content += '${dateTimeItem.hour}:$minutes\n';
                }
              }
            }

            showConfirmationDialog(context, 'Horários do dia ${selectedDay.day}/${selectedDay.month}', content);
          }
        },


        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            bool isAvailable = day.isAfter(DateTime.now().subtract(const Duration(days: 1))) && pageController.selectedDates.contains(day);
            bool isSelectedFinal = pageController.selectedDatesFinal.contains(day);
            bool isFocusedOrSelected = isSameDay(pageController.focusedDay.value, day) || isSameDay(pageController.selectedDay.value, day);
            return Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: isAvailable ? const Color.fromARGB(219, 76, 175, 79) : const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(120),
                border: (isSelectedFinal || isFocusedOrSelected) ? Border.all(color: Colors.red, width: 2) : null,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isAvailable ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          pageController.onDaySelected(selectedDay, focusedDay);
        },
      ),
    ),
  ),
);