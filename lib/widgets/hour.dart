import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyHourCardButton extends StatelessWidget {
  final DateTime label;
  final VoidCallback onPressed;
  final String image;
  final Rx<DateTime> selected;

  const MyHourCardButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.image,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Obx(() { 
            final isSelected = selected.value == label;
            return 
            Material(
              elevation: 8,
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width:  MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: isSelected ? 3 : 2,color: isSelected ?Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 0, 0, 0)),
                  
                  gradient:const LinearGradient(
                    colors: [
                        Color.fromARGB(255, 15, 39, 108),
                        Color.fromARGB(255, 6, 18, 42),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
              
                  )
                ),
                // ignore: unnecessary_string_interpolations
                child: Center(child: Text( '${DateFormat.Hm('pt_BR').format(label.toLocal())}', style: const TextStyle(fontSize: 22,color:  Color.fromARGB(255, 255, 255, 255)),)),
              ),
            );
          }

        ),
      ),
    );
  }
}
