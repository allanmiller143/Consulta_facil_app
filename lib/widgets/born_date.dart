

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget buildDatePickerWidget(Rx<DateTime?> selectedDate, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selecione a data de nascimento' ,style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        
            GestureDetector(
              onTap: () async {
                var datePicked = await DatePicker.showSimpleDatePicker(
                    context,
                    firstDate: DateTime(1890),
                    lastDate: DateTime(2025),
                    dateFormat: "dd-MMMM-yyyy",
                    locale: DateTimePickerLocale.pt_br,
                    looping: true,
                    titleText: 'Data de nascimento',
                    backgroundColor: Color.fromARGB(255, 12, 40, 90),
                    textColor: Color.fromARGB(255, 255, 255, 255),
                    itemTextStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),),
                  );

                  if(datePicked != null){
                    selectedDate.value = datePicked;
                  }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 255, 255, 255)
                ),
                
                child: 
                Center(child: Text(DateFormat.yMMMMd('pt_BR').format(selectedDate.value!.toLocal()),style: const TextStyle(color: Color.fromARGB(255, 13, 101, 156)),)),
              ),
        ),
      ],
    );
}