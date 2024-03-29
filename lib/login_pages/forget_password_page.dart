// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgetPasswordPageController extends GetxController {
  var email = TextEditingController();


  changePassword(context) async{
    if(email.text.isNotEmpty ){
      try{
        showLoad(context);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        Get.back();
        showConfirmationDialog(context,  'Sucesso', 'Um link para redefinir sua senha foi enviado para ${email.text}');
        
      } on FirebaseException catch(e){
        Get.back();
        if(e.code == "user-not-found"){
            showConfirmationDialog(context,  'Alerta', 'Usuario não encontrado, tente novamente!');
        }
        else{
          showConfirmationDialog(context,  'Ocorreu um erro inesperado', 'Por favor, tente novamente mais tarde');
        }
        print(e);
      }
    }else{
      showConfirmationDialog(context,  'Alerta', 'Insira um email para prosseguir!');
    }
    
  }

}

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({Key? key}) : super(key: key);
  var forgetPasswordPageController = Get.put(ForgetPasswordPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<ForgetPasswordPageController>(
        init: ForgetPasswordPageController(),
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
                                  child: Text('Recupere sua senha',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('insira seu E-mail',
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
                                        MyTextFormField(label: 'E-mail', controller: forgetPasswordPageController.email,icon: Icons.mail,),
                                        SizedBox(height: 5,),
                                    
                                        SizedBox(
                                          height: 30,
                                        ),
                                        MyButton(label: 'Enviar E-mail', onPressed: (){ forgetPasswordPageController.changePassword(context);},)
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
