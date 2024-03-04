// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPageController extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  var loginPageController = Get.put(LoginPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<LoginPageController>(
        init: LoginPageController(),
        builder: (_) {
          return Scaffold(
            body: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 15, 39, 108),
                                  Color.fromARGB(255, 6, 18, 42),
                                  ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(MediaQuery.of(context).size.width, 90),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                                child: Center(
                                  child: Text('Sign in',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('Entre na sua conta',
                                  style: TextStyle(
                                    color: Color.fromARGB(200, 255, 255, 255),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                      children: [
                                        MyTextFormField(label: 'E-mail', controller: loginPageController.email,icon: Icons.mail,),
                                        MyTextFormField(label: 'Senha', controller: loginPageController.password,icon:Icons.password,obscureText: true),
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed('/forgetPassword');
                                                print('ir para tela de esqueceu a senha');
                                              },
                                              child: Text('Esqueceu a senha?',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        MyButton(label: 'Entrar', onPressed: (){ Get.toNamed('/home');})

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ainda não possui um conta?  ',style: TextStyle(fontWeight: FontWeight.bold),),
                                  GestureDetector(
                                    onTap: (){
                                      print('abrir tela de cadastro');
                                      Get.toNamed('/signUp');
                                    },
                                  child: Text('Cadastre-se agora!',style: TextStyle(fontWeight: FontWeight.bold,color:Color.fromARGB(255, 15, 39, 108)),)),

                                ],
                              )
                             
                            ],
                          )
                        ],
                      ),
                    ),
            
          );
        },
      ),
    );
  }
}
