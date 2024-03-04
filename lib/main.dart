import 'package:app_clinica/configs/controllers/dependency_injection.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // carregar coisas por fora da aplicação
  Get.put(MyGlobalController()); // carregar coisas por dentro da aplicação
  Get.put(MyGlobalQueryController()); // carregar coisas por dentro da aplicação
  await initializeDateFormatting('th', null); // inicializar o idioma 
  runApp(const MyApp()); // rodar a aplicação
  DependencyInjection.init(); // verificador de conectivodade
}

