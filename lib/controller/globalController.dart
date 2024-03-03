// ignore_for_file: avoid_print, file_names

import 'package:get/get.dart';

class MyGlobalController extends GetxController {
  
  Map<String,dynamic> userInfo = {
                                'E-mail': 'millerallan17@gmail.com',
                                'Nome completo': 'Allan Miller Silva Lima',
                                'CEP': '55750000',
                                'Estado': 'PE',
                                'Cidade': 'Surubim',
                                'Bairro': 'Centro',
                                'Rua' : "Rua das Laranjeiras",
                                'Numero': '10',
                                'Telefone': '81996171889',
                                'cpf': '12678032400',
                                'Data de nascimento': DateTime.now(),
                                'Data': true
                              };

  Map<String,dynamic> userInfo2 = {
                                'E-mail': 'millerallan17@gmail.com',
                                'Data': false
                              };
  List<Map<String,dynamic>> userQueries = [];




}










class MyGlobalQueryController extends GetxController {
  late String specialist;
  late DateTime date;
  late String specialty;
  late String image;


  void addQuery() {
    MyGlobalController myGlobalController = Get.find();
    Map<String,dynamic> query = {
      'Specialist': specialist,
      'Date': date,
      'Specialty': specialty,
      'Image': image

    };
    myGlobalController.userQueries.add(query);

  }
}