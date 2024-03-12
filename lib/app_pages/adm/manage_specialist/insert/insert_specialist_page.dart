import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/services/firebase_functions.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/dropDrown.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/insert_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertSpecialistPageController extends GetxController {
  List<Map<String, dynamic>> queryResults = [];
  late MyGlobalController myGlobalController;
  var name = TextEditingController();
  var crm = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var description = TextEditingController();
  var selectedType = "Especialidade".obs;
  var selectedTypeSex = "Sexo".obs;


  
  @override
  void onInit() {
    myGlobalController = Get.find();
    super.onInit();
  }
  
  List<Widget> buildCards(context, list) {
    List<Widget> cards = [];
        cards.add( buildTextField('Nome completo', name, context));
        cards.add( buildTextField('CRM', crm, context));
        cards.add( buildTextField('E-mail', email, context));
        cards.add( buildTextField('Telefone', phone, context,maxLength: 11));
        cards.add( buildTextField('Descricão:  uma breve  descriçãodo medico/a', description, context,));
        cards.add( CustomDropdownButton(items: const {'Especialidade':'Especialidade','Especialidade1':'Cardiologista','Especialidade2':'Dermatologista','Especialidade3':'Pediatra','Especialidade4':'Neurologista'}, controller: selectedType,label: 'Especialidade do médico/a ',));
        cards.add( Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,0),
          child: CustomDropdownButton(items: const {'Sexo':'Sexo','Sexo1':'Masculino','Sexo2':'Feminino',}, controller: selectedTypeSex,label: 'Sexo do médico/a ',),
        ));

    return cards;
  }

void toNextScreen(context) async {
  String specialistName;

  if (selectedTypeSex.value == 'Masculino') {
    specialistName = 'Dr. ';
  } else {
    specialistName = 'Dra. ';
  }

  String fullName = name.text;
  List<String> nameParts = fullName.split(' ');

  specialistName += (nameParts.length >= 2)
      ? '${nameParts.first} ${nameParts.last}'
      : fullName;

  var specialistInfo = {
    'specialist': specialistName,
    'name': name.text,
    'crm': crm.text,
    'phone': phone.text,
    'email': email.text,
    'description': description.text,
    'user_type': '2',
    'gender': selectedTypeSex.value[0], // Ajuste para acessar o valor atual da observável
    'specialty': selectedType.value, // Ajuste para acessar o valor atual da observável
    'search': name.text[0].toUpperCase(),
  };
  
  if(await registerUserWithEmailAndPassword(email.text,context)){
    print(specialistInfo);
    showLoad(context);
    await insertApi('doctor', specialistInfo);
    Get.back();
    Get.toNamed('/insert_horary_specialist');
  }
  else{
    Get.back();
    showConfirmationDialog(context, 'Alerta', 'Ocorreu um erro ao cadastrar o usuario!\nTente novamente mais tarde!');
  }


  
}
  
  init() async {
    queryResults = [{},{}];
    return queryResults;
  }

}

// ignore: must_be_immutable
class InsertSpecialistPage extends StatelessWidget {
  InsertSpecialistPage({Key? key}) : super(key: key);
  var insertSpecialistPageController = Get.put(InsertSpecialistPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<InsertSpecialistPageController>(
        init: InsertSpecialistPageController(),
        builder: (_) {
          return Scaffold( 
            body: FutureBuilder(
              future: insertSpecialistPageController.init(),
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
                                   'Inserir médico/a',
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
                                  children: insertSpecialistPageController.buildCards(context, insertSpecialistPageController.queryResults),
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
                                        'Ao cadastrar um novo médico, será gerada uma conta com o e-mail informado e a senha padrão: <consulta_123>',
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
                            MyButton(label: 'Cadastrar horários', onPressed: (){insertSpecialistPageController.toNextScreen(context);},width: 250),
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




