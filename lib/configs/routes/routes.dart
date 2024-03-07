import 'package:app_clinica/app_pages/adm/adm_home_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/adm_manage_specialist_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/insert/inser_specialist_horary_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/insert/insert_specialist_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/update/list_specialist_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/update/select_specialist_update_type.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/update/update_specialist_horary_page.dart';
import 'package:app_clinica/app_pages/adm/manage_specialist/update/update_specialist_page.dart';
import 'package:app_clinica/app_pages/user/home_page.dart';
import 'package:app_clinica/app_pages/user/my_queries_pages/my_edit_query_page.dart';
import 'package:app_clinica/app_pages/user/my_queries_pages/my_queries.dart';
import 'package:app_clinica/app_pages/user/my_queries_pages/my_query_details.dart';
import 'package:app_clinica/app_pages/user/profile_pages/edit_info_page.dart';
import 'package:app_clinica/app_pages/user/profile_pages/profile_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/insert_data_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/select_day_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/select_doctor_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/select_hour_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/select_specialty_page.dart';
import 'package:app_clinica/configs/default_pages/no_internet_page.dart';
import 'package:app_clinica/login_pages/forget_password_page.dart';
import 'package:app_clinica/login_pages/login_page.dart';
import 'package:app_clinica/login_pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        //GetPage(name: '/', page: () => InsertUserDataPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        //GetPage(name: '/', page: () => ProfilePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        //GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/', page: () => LoginPage()),
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
        GetPage(name: '/internet', page: () => NoInternetPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/query_details', page: () => QueriesDetailsPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/edit_query', page: () => EditQueriesPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/adm_home', page: () => AdmHomePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/manage_specialist', page: () => ManageSpecialistPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/insert_specialist', page: () => InsertSpecialistPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/list_specialist', page: () => ListSpecialistPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/update_specialist', page: () => UpdateSpecialistPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/insert_horary_specialist', page: () => InsertSpecialistsDaysPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/select_specialist_update_type', page: () => SelectSpecialistUpdatePage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),
        GetPage(name: '/insert_specialist_horary', page: () => InsertSpecialistHoraryPage(),transition: Transition.rightToLeft,transitionDuration: const Duration(milliseconds: 400)),







      ],
    );
  }
}