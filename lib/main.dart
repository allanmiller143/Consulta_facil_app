import 'package:app_clinica/app_pages/my_queries_pages/my_queries.dart';
import 'package:app_clinica/app_pages/profile_pages/edit_info_page.dart';
import 'package:app_clinica/app_pages/profile_pages/profile_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/insert_data_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_day_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_doctor_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_hour_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_specialty_page.dart';
import 'package:app_clinica/controller/globalController.dart';
import 'package:app_clinica/login_pages/forget_password_page.dart';
import 'package:app_clinica/login_pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app_pages/home_page.dart';
import 'package:get/get.dart';


void main() async {
  Get.put(MyGlobalController());
  Get.put(MyGlobalQueryController());
  await initializeDateFormatting('th', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        //GetPage(name: '/', page: () => InsertUserDataPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        //GetPage(name: '/', page: () => ProfilePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),

        GetPage(name: '/', page: () => HomePage()),
        // GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/signUp', page: () => SignUpPage()),
        //GetPage(name: '/', page: () => SelectDatePage()),
        GetPage(name: '/forgetPassword', page: () => ForgetPasswordPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfilePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/agendar', page: () => SelectSpecialtyPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/doctor', page: () => SelectDoctorPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/date', page: () => SelectDatePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/hour', page: () => SelectHourPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/queries', page: () => QueriesPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/insert_data', page: () => InsertUserDataPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/edit', page: () => EditProfilePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),


      
      ],
    );
  }
}