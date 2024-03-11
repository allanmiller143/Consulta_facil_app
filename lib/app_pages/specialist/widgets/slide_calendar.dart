import 'package:app_clinica/app_pages/specialist/my_queries_specialist_pages/my_queries_specialist.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomCalendarSlider extends StatelessWidget {
  final CalendarSliderController controller = CalendarSliderController();
  final RxString containerText;
  final Rx<DateTime> selectedDate;
  final SpecialistQueriesPageController specialistQueriesPageController = Get.find();

  CustomCalendarSlider({Key? key, required this.containerText,required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width/3;
    double containerHeight = MediaQuery.of(context).size.height * 0.06;
    int conter = 2;
    return Stack(
      children: [
        SizedBox(
          height: 270,
          child: CalendarSlider(
            fullCalendar: false,
            controller: controller,
            selectedDayPosition: SelectedDayPosition.center,
            fullCalendarScroll: FullCalendarScroll.vertical,
            backgroundColor: const Color.fromARGB(0, 45, 166, 41),
            fullCalendarWeekDay: WeekDay.long,
            selectedTileBackgroundColor: Colors.white,
            monthYearButtonBackgroundColor: const Color.fromARGB(255, 25, 100, 157),
            monthYearTextColor: Colors.black,
            tileBackgroundColor: const Color.fromARGB(255, 25, 100, 157),
            selectedDateColor: Colors.black,
            dateColor: Colors.white,
            tileShadow: BoxShadow(
              color: Colors.black.withOpacity(1),
            ),
            locale: 'pt',
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 20)),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            onDateSelected: (date) async {
              containerText.value = DateFormat('MMMM yyyy', 'pt_BR').format(date);
              
              showLoad(context);
              conter%2 == 0 ?
              specialistQueriesPageController.queryResults = await specialistQueriesPageController.myGlobalController.fetchDataFromApi('Consultas2'):
              specialistQueriesPageController.queryResults = await specialistQueriesPageController.myGlobalController.fetchDataFromApi('Consultas');
              selectedDate.value = date;
              conter++;

              Get.back();            
            },
          ),
        ),
        Positioned(
          top: 8,
          left: MediaQuery.of(context).size.width / 2 - (MediaQuery.of(context).size.width) / 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(0, 17, 46, 97),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: MyHeader(),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.12,
          left: MediaQuery.of(context).size.width / 2 - (containerWidth) / 2,
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(0, 25, 100, 157),
            ),
            child: Obx(
              () => Center(
                child: Text(
                  containerText.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
