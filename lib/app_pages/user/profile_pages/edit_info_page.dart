// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:app_clinica/app_pages/user/profile_pages/profile_page.dart';
import 'package:app_clinica/app_pages/user/profile_pages/validade_user_edit_page.dart';

import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/services/complete_cep.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/born_date.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/insert_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfilePageController extends GetxController {
  late Map<String,dynamic>  info;
  late MyGlobalController myGlobalController;
  late ProfilePageController profilePageController;

  @override
  void onInit() {
    myGlobalController = Get.find();
    profilePageController = Get.find();
    info = profilePageController.infoSelected;

    if(myGlobalController.userInfo['data'] == true){
      cpf.text = myGlobalController.userInfo['cpf'];
      cep.text = myGlobalController.userInfo['cep'];
      nome.text = myGlobalController.userInfo['name'];
      email.text = myGlobalController.userInfo['email'];
      telefone.text = myGlobalController.userInfo['phone'];
      rua.text = myGlobalController.userInfo['address'];
      numero.text = myGlobalController.userInfo['house_number'];
      estado.text = myGlobalController.userInfo['state'];
      bairro.text = myGlobalController.userInfo['neighborhood'];
      cidade.text = myGlobalController.userInfo['city'];
      selectedDate.value = myGlobalController.userInfo['birth_date'];
    }
    else{
      email.text = myGlobalController.userInfo['email'];
    }
    
    super.onInit();
  }

  Future<void> completeCep(cep, context) async {
    Map<String, dynamic> dados = await searchCep(cep);

    if (dados.containsKey('bairro') && dados['bairro'] == '') {
      bairroAtivado.value = true;
    } else {
      bairroAtivado.value = false;
    }

    if (dados.containsKey('logradouro') && dados['logradouro'] == '') {
      ruaAtivado.value = true;
    } else {
      ruaAtivado.value = false;
    }

    if (dados.containsKey('uf') && dados['uf'] == '') {
      showConfirmationDialog(
        context,
        'Alerta',
        'Insira um CEP válido para completar os campos! ',
      );
    }

    // Verifica se a chave 'localidade' existe e não é nula antes de acessá-la
    cidade.text = dados.containsKey("localidade") ? dados["localidade"] : '';
    estado.text = dados.containsKey("uf") ? dados["uf"] : '';
    bairro.text = dados.containsKey('bairro') ? dados['bairro'] : '';
    rua.text = dados.containsKey('logradouro') ? dados['logradouro'] : '';
    telefone.text = dados.containsKey('ddd') ? dados['ddd'] : '';
}
  

  var cpf = TextEditingController();
  var email = TextEditingController();
  var rua = TextEditingController();
  var numero = TextEditingController();
  var estado = TextEditingController();
  var cidade = TextEditingController();
  var bairro = TextEditingController();
  var telefone = TextEditingController();
  var ruaAtivado  = false.obs;
  var bairroAtivado  = false.obs;
  var cep = TextEditingController();
  var nome = TextEditingController(); 
  Rx<DateTime?> selectedDate = DateTime.now().obs;

  List<Widget> buildWidgets(context) {
    List<Widget> cards = [];
    if(info['title'] == 'Dados Pessoais'){
      if(info['campos'].length >2){
        cards.add( buildTextField(info['campos'][0], nome, context,type: 1));
        cards.add( buildTextField(info['campos'][1], cpf, context,maxLength: 11,type: 1));
        cards.add( buildTextField(info['campos'][2], telefone, context,maxLength: 11,type: 1));
        cards.add( buildTextField(info['campos'][3], email, context,type: 1));
        cards.add( Obx(()=> buildDatePickerWidget(selectedDate, context,)));
      }
      else{
        cards.add( buildTextField(info['campos'][0], email, context,type: 1));
      }
      
    }
    if(info['title'] == 'Endereço'){
        cards.add( buildTextField(info['campos'][0], cep, context,maxLength: 8,type: 1,keyboard: 'number'));
        cards.add( buildTextField(info['campos'][1], estado, context, ativated: false,type: 1));
        cards.add( buildTextField(info['campos'][2], cidade, context,ativated: false,type: 1));
        cards.add( buildTextField(info['campos'][3], bairro, context,ativated: bairroAtivado.value,type: 1));
        cards.add( buildTextField(info['campos'][4], rua, context,ativated: ruaAtivado.value,type: 1));
        cards.add( buildTextField(info['campos'][5], numero, context,type: 1,keyboard: 'number'));

    }
    return cards;
  }

  void change(context){
    Map<String,dynamic> data;

    if(info['title'] == 'Dados Pessoais' && info['campos'].length >2){
      data = {
        'name': nome.text,
        'cpf': cpf.text,
        'phone': telefone.text,
        'email': email.text,
        'birth_date': selectedDate.value
      };

      validarCamposEdit(data, context);
    }
    if(info['title'] == 'Endereço'){
      data = {
        'cep': cep.text,
        'state': estado.text,
        'city': cidade.text,
        'neighborhood': bairro.text,
        'adrress' : rua.text,
        'house_number': numero.text,
      };
      validateEditAddress(data, context);
    }

  }
}




class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  var editProfilePageController = Get.put(EditProfilePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<EditProfilePageController>(
        init: EditProfilePageController(),
        builder: (_) {
          return Scaffold(
            body:Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: Column(
                  children: [
                    MyHeader(),
                    const Text('Altere seus dados',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                    Expanded(
                      child: ListView(
                        children: editProfilePageController.buildWidgets(context),
                      )
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Icon(Icons.info,color: const Color.fromARGB(255, 255, 255, 255),),
                        SizedBox(width: 10,),
                        Expanded(
                          child: SizedBox(
                            width: 50,
                            child: Text(
                              'Apenas as informações alteradas serão salvas, as demais não serão alteradas',
                              style: TextStyle(
                                color: Color.fromARGB(222, 255, 255, 255),
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    MyButton(label: 'Salvar', borderRadius: BorderRadius.circular(50),  onPressed: (){editProfilePageController.change(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                    SizedBox(height: 30,),     
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
