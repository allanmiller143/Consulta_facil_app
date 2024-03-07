// ignore_for_file: avoid_print, file_names

import 'package:app_clinica/configs/controllers/jsons.dart';
import 'package:get/get.dart';
//import 'package:random_string/random_string.dart';

class MyGlobalController extends GetxController {
  
  late List<Map<String,dynamic>> userInfo;
  List<Map<String,dynamic>> userQueries = [];
  RxBool internet = true.obs;
  late String token;


  Future<List<Map<String, dynamic>>> fetchDataFromApi(barra) async { // simula uma consulta na API
    try {
      // Simula um atraso de 2 segundos para a resposta da API
      await Future.delayed(const Duration(seconds: 0));
      var responseData = a[barra];
      return responseData;
    } catch (e) {
      // Se ocorrer um erro durante a simulação, lança uma exceção
      throw Exception('Erro ao consultar a API: $e');
    }
  }

}










class MyGlobalQueryController extends GetxController {
  late String queryState;
  late String currentQueryId;
  late String specialist;
  late DateTime date;
  late String specialty;
  late Map<String,dynamic> editedQuery; 

  void addEditedQuery (query){
    editedQuery = query;
  }


  


  void resetVariables() {
    queryState = '';
    currentQueryId = '';
    specialist = '';
    date = DateTime.utc(0, 0, 0);
    specialty = '';
  }

  void addQuery() {
    MyGlobalController myGlobalController = Get.find();
    //String idQuery = randomAlphaNumeric(10);
    Map<String,dynamic> query = {
      'Specialist': specialist,
      'Date': date,
      'Specialty': specialty,
      'Query_id': 'asdf'

    };
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