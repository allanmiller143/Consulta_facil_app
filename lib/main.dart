import 'package:app_clinica/configs/controllers/dependency_injection.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/routes/routes.dart';
import 'package:app_clinica/firebase_options.dart';
import 'package:app_clinica/services/firebase_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';


void main() async {
  
  Get.put(MyGlobalController()); // carregar coisas por dentro da aplicação
  Get.put(MyGlobalQueryController()); // carregar coisas por dentro da aplicação
  WidgetsFlutterBinding.ensureInitialized(); // carregar coisas por fora da aplicação
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotification().initNotications();
  await initializeDateFormatting('th', null); // inicializar o idioma 
  runApp(const MyApp()); // rodar a aplicação
  DependencyInjection.init(); // verificador de conectivodade
}

