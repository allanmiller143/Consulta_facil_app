import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> searchCep(String cep) async {
  
  final url = Uri.parse('https://viacep.com.br/ws/$cep/json/'); // passo 1 - difinir a url de dados


  http.Response response; 

  response = await http.get(url); //passo 3 efetar a requisição
  
  Map<String, dynamic> data = {};

  if (response.statusCode == 200) {
    // manipular os dados que estao em formato de json.
    data = json.decode(response.body);
    print(data);
    if(data['erro'] == true){
      data = {
      "cep": "",
      "logradouro": "",
      "bairro": "",
      "localidade": "",
      "uf": "",
      "ddd": ""
    };        
    }
  }return data;
}