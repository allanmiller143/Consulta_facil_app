import 'package:app_clinica/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SpecialistCard extends StatelessWidget {
  final Map<String, dynamic> info;
  final RxBool finished = false.obs;
  final RxBool cancel = false.obs;

  SpecialistCard({Key? key, required this.info}) : super(key: key);


  @override
  Widget build(BuildContext context) {
String horary = DateFormat('HH:mm').format(info['Date']);
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 25, 100, 157),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5,),
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.calendar_month, color: Color.fromARGB(255, 255, 255, 255),size: 15,),
              const SizedBox(width: 5),
              Text(horary, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 255, 255, 255)),),
              const SizedBox(width: 5),
            ],
          ),
          Padding(

            padding:const  EdgeInsets.fromLTRB(10,0,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Paciente: ${info['UserName']}', style:const  TextStyle(fontSize: 12,fontWeight: FontWeight.w600, color: Color.fromARGB(255, 255, 255, 255)),),
                    Text('Id da consulta: ${info['Query_id']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: Color.fromARGB(255, 255, 255, 255)),),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: finished.value,
                      shape: const CircleBorder(),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide.none,
                      fillColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 255, 255, 255)),
                      checkColor: Color.fromARGB(255, 17, 57, 89),
                      onChanged: (value) {
                        if(!cancel.value){
                          finished.value = value!;
                          print(info);
                        }
                        
                      },
                    ),
                  ),
                  const Text('Finalizar', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400, color: Color.fromARGB(255, 255, 255, 255)),),
                ],
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: cancel.value,
                      shape: const CircleBorder(),
                       visualDensity: VisualDensity.compact,
                      side: BorderSide.none,
                      fillColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 255, 255, 255)),
                      checkColor: Color.fromARGB(255, 17, 57, 89),
                      onChanged: (value) {
                        if(!finished.value){
                          if(!cancel.value){
                            showConfirmationDialogFunction2(context, 'Deseja mesmo cancelar a consulta?', 'Caso sim, o paciente receberá uma notificação',
                              (){ Get.back();cancel.value = value!;}
                            );

                          }
                          
                        }
                        
                        
                      },
                    ),
                  ),
                  Text('Cancelar', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400, color: Color.fromARGB(255, 255, 255, 255)),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
