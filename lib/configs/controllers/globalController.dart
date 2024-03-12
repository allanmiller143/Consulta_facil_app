// ignore_for_file: avoid_print, file_names

import 'package:app_clinica/configs/controllers/jsons.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/services/api.dart';
import 'package:get/get.dart';

//import 'package:random_string/random_string.dart';

class MyGlobalController extends GetxController {
  
  late var userInfo;
  List<Map<String,dynamic>> userQueries = [];
  RxBool internet = true.obs;
  late String token;


  fetchDataFromApi(barra) async { // simula uma consulta na API
    try {
      // Simula um atraso de 2 segundos para a resposta da API
      await Future.delayed(const Duration(seconds: 1));
      var responseData = a[barra];
      return responseData;
    } catch (e) {
      // Se ocorrer um erro durante a simulação, lança uma exceção
      throw Exception('Erro ao consultar a API: $e');
    }
  }

}










class MyGlobalQueryController extends GetxController {
  
  late String currentQueryId;
  
  late String queryState;
  late String specialist;
  late DateTime date;
  late String specialty;
  late Map<String,dynamic> editedQuery; 
  late String crm;


  void addEditedQuery (query){
    editedQuery = query;
  }


  void resetVariables() {
    queryState = '';
    currentQueryId = '';
    specialist = '';
    date = DateTime.utc(0, 0, 0);
    crm = '';
    specialty = '';
  }

  void addQuery(context) async {
    MyGlobalController myGlobalController = Get.find();

    Map<String,dynamic> query = {
      'user_email': myGlobalController.userInfo['email'],
      'user_name' : myGlobalController.userInfo['name'],
      'date': date.toIso8601String(),
      'specialty': specialty,
      'doctor_crm': crm,
      'status': 'Aberta',
      'specialist': specialist

    };
    showLoad(context);
    await insertApi('appointment', query);
    await searchApi("specialist/unavailable/$crm/${date.toIso8601String()}");
    
    Get.back();
    myGlobalController.userQueries.add(query);

  }

  void editQuery(query_id) {
    print('chamei a funcao');
    MyGlobalController myGlobalController = Get.find();
    //String idQuery = randomAlphaNumeric(10);
    Map<String,dynamic> query = {
      'Specialist': specialist,
      'Date': date,
      'Specialty': specialty,
      'Query_id': query_id

    };
    for(int i = 0;i<myGlobalController.userQueries.length; i++){
      if(myGlobalController.userQueries[i]['Query_id'] == query_id ){
        print('achei');
        myGlobalController.userQueries[i].addAll(query);
      }

    }
  }
}