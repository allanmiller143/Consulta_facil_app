import 'package:app_clinica/app_pages/adm/manage_specialist/update/list_specialist_page.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/insert_textfield.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateSpecialistPageController extends GetxController {
  List<Map<String, dynamic>> queryResults = [];
  late MyGlobalController myGlobalController;
  late ListSpecialistPageController listSpecialistPageController;
  var name = TextEditingController();
  var crm = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  @override
  void onInit() {
    myGlobalController = Get.find();
    listSpecialistPageController = Get.find();
    name.text = listSpecialistPageController.currentSpecialist['Name'];
    crm.text = listSpecialistPageController.currentSpecialist['CRM'];
    phone.text = listSpecialistPageController.currentSpecialist['Phone'];
    email.text = listSpecialistPageController.currentSpecialist['E-mail'];
    super.onInit();
  }
  
  List<Widget> buildCards(context, list) {
    List<Widget> cards = [];
        cards.add( buildTextField('Nome completo', name, context));
        cards.add( buildTextField('CRM', crm, context));
        cards.add( buildTextField('E-mail', email, context));
        cards.add( buildTextField('Telefone', phone, context,maxLength: 11));
    return cards;
  }

  removeSpecialist(context) {
    showConfirmationDialogFunction2(
      context, 'Você está prestes a remover o ${listSpecialistPageController.currentSpecialist['Name']}', 
      'Ao remover este especialista, todos os seus dados serão excluídos, incluindo consultas, ou seja, rodas as consultas pendentes desse médico serão automaticamente removidas.\nTem certeza de que deseja remover este especialista?',
       () async {
        Get.back();
        print('remover consultas e medicos do sistema');

       }
      );
  }

  updateData(context){
    if(name.text.isEmpty || crm.text.isEmpty || phone.text.isEmpty || email.text.isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, confira se todos os campos foram preenchidos corretamente.');
    }
    else{
      showConfirmationDialog(context, 'Alerta', 'Dados atualizados com sucesso!');
    }
  }



  
  init() async {
    queryResults = [{},{}];
    return queryResults;
  }

}

// ignore: must_be_immutable
class UpdateSpecialistPage extends StatelessWidget {
  UpdateSpecialistPage({Key? key}) : super(key: key);
  var updateSpecialistPageController = Get.put(UpdateSpecialistPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<UpdateSpecialistPageController>(
        init: UpdateSpecialistPageController(),
        builder: (_) {
          return Scaffold( 
            body: FutureBuilder(
              future: updateSpecialistPageController.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 15, 39, 108),
                            Color.fromARGB(255, 6, 18, 42),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Column(
                          children: [
                            const Padding(
                              padding:   EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                children: [
                                  MyHeader(),
                                  Text(
                                   'Edite ou remova o médico',
                                    style:  TextStyle(
                                      fontFamily: 'Nunito-VariableFont_wght',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                   SizedBox(height: 5),
                                ],
                              ),
                            ),
                            Expanded(
                              
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,), 
                                child: ListView(
                                  children: updateSpecialistPageController.buildCards(context, updateSpecialistPageController.queryResults),
                                ),
                              )
                            ),
                            const SizedBox(height: 30),
                            const Padding(
                              padding:  EdgeInsets.fromLTRB(20,0,20,0),
                              child:  Row(
                                children: [
                                  Icon(Icons.info,color:  Color.fromARGB(255, 255, 255, 255),),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: SizedBox(
                                      width: 50,
                                      child: Text(
                                        'Apenas as informações alteradas serão salvas.',
                                        style: TextStyle(
                                          color: Color.fromARGB(222, 255, 255, 255),
                                          fontWeight: FontWeight.w600
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyButton(label: 'Salvar', borderRadius: BorderRadius.circular(50),  onPressed: (){updateSpecialistPageController.updateData(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                                MyButton(label: 'Excluir', borderRadius: BorderRadius.circular(50),  onPressed: (){updateSpecialistPageController.removeSpecialist(context); },color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 230, 5, 5)),

                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    );
                    
                   }else{
                    return Center(child: Text(snapshot.error.toString()));
                   }
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar a lista ${snapshot.error}');
                  } else {
                  return const LoadingWidget();
                  }
              }
            ),
          );
        },
      ),
    );
  }
}




