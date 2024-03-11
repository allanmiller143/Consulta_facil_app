// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;



String URL = 'https://137c-2804-29b8-515c-19b-87b-5139-5c72-de13.ngrok-free.app/';

searchApi(String route) async {
  final url = Uri.parse('$URL$route');
  try {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print('Erro na requisição: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return null;
  }
}



insertApi(String route, Map<String, dynamic> data) async {
  final url = Uri.parse('$URL$route');
  try {
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print('inserção com sucesso: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return null;
  }
}



updateApi(String route, Map<String, dynamic> data) async {
  final url = Uri.parse('$URL$route');
  try {
    http.Response response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Atualização com sucesso: ${response.body}');
      return json.decode(response.body);
    } else {
      print('sucesso: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return null;
  }
}


deleteApi(String route) async {
  final url = Uri.parse('$URL$route');
  try {
    http.Response response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Exclusão com sucesso: ${response.body}');
      return json.decode(response.body);
    } else {
      print(url);
      print('sucesso: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return null;
  }
}
