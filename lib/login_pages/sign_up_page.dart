// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print, unused_local_variable
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPageController extends GetxController {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  late MyGlobalController myGlobalController;

  signUp(context) async {
    myGlobalController = Get.find();
    if(password.text.isNotEmpty && password.text == confirmPassword.text){
      print('entrei aqui');
      try{
        showLoad(context);
      
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
  
        Map<String,dynamic> userInfoMap = {
          'email': email.text,
          'data': false,
          'user_type': '1',
          'token': myGlobalController.token
        };

        await insertApi('user',userInfoMap);
        myGlobalController.userInfo = userInfoMap;

        Get.back();
        Get.toNamed('/home');
      }on FirebaseAuthException catch(e){
        Get.back();
        if(e.code == 'weak-password'){
          showConfirmationDialog(context,  'Senha fraca', 'por favor tente uma senha mais forte, uma senha com pelo menos 6 digitos');
        }
        if(e.code == 'email-already-in-use'){
          showConfirmationDialog(context,  'Esse e-mail está em uso',   'Por favor tente outro e-mail');
        }
        showConfirmationDialog(context,  'Erro inesperado',   'Por favor tente mais tarde');

      }
    }
    else{
      showConfirmationDialog(context,  'Preencha todos os campos',   'todos os campos devem ser preenchidos corretamente');


    }

  }







}

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  var signUpPageController = Get.put(SignUpPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SignUpPageController>(
        init: SignUpPageController(),
        builder: (_) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 255, 255, 255),)),
              ),
              toolbarHeight: 80,

            ),
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
                                  child: Text('Sign Up',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('Crie sua conta',
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
                                        MyTextFormField(label: 'E-mail', controller: signUpPageController.email,icon: Icons.mail,),
                                        MyTextFormField(label: 'Senha', controller: signUpPageController.password,icon:Icons.password,obscureText: true),
                                        MyTextFormField(label: 'confirme a senha', controller: signUpPageController.confirmPassword,icon:Icons.password,obscureText: true),

                                        SizedBox(height: 5,),
                                        
                                        SizedBox(
                                          height: 30,
                                        ),
                                        MyButton(label: 'Cadastrar', onPressed: (){signUpPageController.signUp(context);})
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
