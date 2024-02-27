import 'package:app_clinica/app_pages/profile_page.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_doctor.dart';
import 'package:app_clinica/app_pages/register_query_pages/select_specialty_page.dart';
import 'package:app_clinica/login_pages/forget_password_page.dart';
import 'package:app_clinica/login_pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'app_pages/home_page.dart';
import 'package:get/get.dart';
import 'login_pages/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        //GetPage(name: '/', page: () => HomePage()),
        //GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/signUp', page: () => SignUpPage()),
        GetPage(name: '/forgetPassword', page: () => ForgetPasswordPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/', page: () => SelectSpecialtyPage()),
        GetPage(name: '/doctor', page: () => SelectDoctorPage()),

      
      ],
    );
  }
}