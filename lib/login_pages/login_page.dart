// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageController extends GetxController {
  late MyGlobalController myGlobalController;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void onInit() {
    myGlobalController = Get.find();
    super.onInit();
  }


  login(context) async{
    if(email.text.isNotEmpty || password.text.isNotEmpty){
      try{
        showLoad(context);
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
        myGlobalController.userInfo = await searchApi('user/${email.text}');


        if(myGlobalController.userInfo == null){
          Get.back();
          showConfirmationDialog(context,  'Alerta', 'Email ou senha invalida');
          return;
        }

        if (myGlobalController.userInfo != null && myGlobalController.userInfo['birth_date'] != null) {
          myGlobalController.userInfo['birth_date'] = DateTime.parse(myGlobalController.userInfo['birth_date']);
        }
        email.clear();
        password.clear();

        if(myGlobalController.userInfo['user_type'] == '1'){
          Get.back();
          Get.toNamed('/home');
        }else if(myGlobalController.userInfo['user_type'] == '2'){
          Get.back();
          Get.toNamed('/specialist_home');

        }
        else{
          Get.back();
          Get.toNamed('/adm');

        }

        
      } on FirebaseException catch(e){
        Get.back();
        if(e.code == 'invalid-credential' || e.code == 'wrong-password'){
          showConfirmationDialog(context,  'Alerta', 'Email ou senha invalida');
        }
        else{
          showConfirmationDialog(context,  'Alerta', 'Ocorreu um erro inesperado, tente novamente mais tarde');
        }
      }
    }else{
          showConfirmationDialog(context,  'Alerta', 'Preencha todos os campos');

    }
    
  }
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
                                        MyButton(
                                        label: 'Entrar', onPressed: (){loginPageController.login(context);})

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
