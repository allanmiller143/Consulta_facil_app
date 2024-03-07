import 'package:app_clinica/app_pages/adm/manage_specialist/insert/inser_specialist_horary_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:table_calendar/table_calendar.dart';

Widget buildHoraryCalendar(InsertSpecialistHoraryPageController selectDayPageController) => Obx(
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
        rowHeight: 40,
        firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 14),
        focusedDay: selectDayPageController.focusedDay.value,
        selectedDayPredicate: (day) {
          return  selectDayPageController.selectedDay.value.isAfter(DateTime.now().subtract(const Duration(days: 1))) && isSameDay(selectDayPageController.selectedDay.value, day);
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
          selectedTextStyle: const TextStyle(color: Colors.black),
          selectedDecoration: BoxDecoration(
            
            color:  selectDayPageController.selectedDates.contains(selectDayPageController.focusedDay.value) ?   Colors.green : Color.fromARGB(184, 255, 255, 255), // Defina a cor de destaque do dia selecionado
          
            borderRadius: BorderRadius.circular(120),
          ),
          
          isTodayHighlighted: false
        ),
        calendarBuilders: CalendarBuilders(
         defaultBuilder: (context, day, focusedDay) {
  bool isAvailable = day.isAfter(DateTime.now().subtract(const Duration(days: 1))) && selectDayPageController.selectedDates.contains(day);
  bool isSelectedFinal = selectDayPageController.selectedDatesFinal.contains(day); // Verifica se a data está em selectedDatesFinal
  bool isFocusedOrSelected = isSameDay(selectDayPageController.focusedDay.value, day) || isSameDay(selectDayPageController.selectedDay.value, day); // Verifica se o dia está focado ou selecionado
  
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: isAvailable ? Color.fromARGB(219, 76, 175, 79) : Color.fromARGB(255, 255, 255, 255), // Cor verde se disponível, senão branco
      borderRadius: BorderRadius.circular(120),
      border: (isSelectedFinal || isFocusedOrSelected) ? Border.all(color: Colors.red, width: 2) : null, // Adiciona uma borda vermelha se a data estiver em selectedDatesFinal ou se o dia estiver focado/selecionado
    ),
    child: Center(
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: isAvailable ? const Color.fromARGB(255, 0, 0, 0) : Colors.black, // Texto branco se disponível, senão preto
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




