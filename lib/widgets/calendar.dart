



import 'package:app_clinica/app_pages/user/register_query_pages/select_day_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:table_calendar/table_calendar.dart';

Widget buildCalendar(SelectDayPageController selectDayPageController) => Obx(
  () => Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    child: Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white, // Define a cor de fundo como branco
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 14),
        focusedDay: selectDayPageController.focusedDay.value,
        selectedDayPredicate: (day) {
          return  selectDayPageController.selectedDay.value.isAfter(DateTime.now().subtract(const Duration(days: 1))) && selectDayPageController.isDateAvailable(day) && isSameDay(selectDayPageController.selectedDay.value, day);
        },
        headerStyle: const HeaderStyle(
          
          titleCentered: true,
          formatButtonVisible: false, // Define a visibilidade do botão de alternância de visualização
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 6, 26, 54), // Define a cor de fundo como branco
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
            
          )
        ),
        locale: 'pt_BR',
        calendarStyle: CalendarStyle(
          
          selectedDecoration: BoxDecoration(
            color:const  Color.fromARGB(255, 12, 90, 116), // Defina a cor de destaque do dia selecionado
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(120),
          ),
          isTodayHighlighted: false
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            bool isAvailable = selectDayPageController.isDateAvailable(day) && day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
            return Container(
              decoration: BoxDecoration(
                color: isAvailable ? Colors.green : Colors.white, // Cor verde se disponível, senão branco
                borderRadius: BorderRadius.circular(120),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isAvailable ? Colors.white : Colors.black, // Texto branco se disponível, senão preto
                  ),
                ),
              ),
            );
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          selectDayPageController.onDaySelected(selectedDay, focusedDay);
        },
      ),
    ),
  ),
);




