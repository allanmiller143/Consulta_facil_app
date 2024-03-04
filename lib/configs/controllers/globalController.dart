// ignore_for_file: avoid_print, file_names

import 'package:get/get.dart';

class MyGlobalController extends GetxController {
  
  Map<String,dynamic> userInfo = 
  {
    'E-mail': 'millerallan17@gmail.com',
    'Nome completo': 'Miller Allan',
    'cpf': '12678032400',
    'CEP': '50100000',
    'Telefone': '8199868565',
    'Rua': 'Rua',
    'Numero': '123',
    'Bairro': 'Bairro',
    'Cidade': 'Cidade',
    'Estado': 'SP',
    'Data de nascimento': DateTime.now(),
    'Data': true
  };

  List<Map<String,dynamic>> userQueries = [];
  RxBool internet = true.obs;


  Future<List<Map<String, dynamic>>> fetchDataFromApi() async { // simula uma consulta na API
    try {
      // Simula um atraso de 2 segundos para a resposta da API
      await Future.delayed(const Duration(seconds: 0));

      // Simula dados de resposta da API
      List<Map<String, dynamic>> responseData = [
            {
              'title': 'Cardiologista',
              'imageAsset': 'assets/imgs/Cardiologista.png',
              'content': 'O cardiologista é um médico especializado em cuidar do sistema cardiovascular, tratando condições como doenças cardíacas, hipertensão e insuficiência cardíaca.',
              'search' : 'c'
            },
            {
              'title': 'Dermatologista',
              'imageAsset': 'assets/imgs/Dermatologista.png',
              'content': 'O dermatologista é um especialista em doenças da pele, cabelo e unhas, podendo tratar condições como acne, eczema, psoríase e câncer de pele.',
              'search' : 'D'
            },
            {
              'title': 'Ortopedista',
              'imageAsset': 'assets/imgs/Ortopedista.png',
              'content': 'O ortopedista é um médico que se dedica ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
              'search' : 'o'
            },
            {
              'title': 'Oftalmologista',
              'imageAsset': 'assets/imgs/Oftamologista.png',
              'content': 'O oftalmologista é responsável pelo diagnóstico e tratamento de condições oculares, como miopia, astigmatismo, catarata e glaucoma.',
              'search' : 'o'
            },
            {
              'title': 'Ginecologista',
              'imageAsset': 'assets/imgs/Ginecologista.png',
              'content': 'O ginecologista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
              'search' : 'g'
            },
            {
              'title': 'Dentista',
              'imageAsset': 'assets/imgs/Dentista.png',
              'content': 'O dentista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
              'search' : 'd'
            },


      ];
      return responseData;
    } catch (e) {
      // Se ocorrer um erro durante a simulação, lança uma exceção
      throw Exception('Erro ao consultar a API: $e');
    }
  }

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