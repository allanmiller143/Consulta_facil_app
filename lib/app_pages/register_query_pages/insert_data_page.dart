
// ignore_for_file: must_be_immutable
import 'package:app_clinica/app_pages/register_query_pages/validate_user_data.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/services/complete_cep.dart';
import 'package:app_clinica/widgets/Born_date.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/insert_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertUserDataPageController extends GetxController {
  late MyGlobalController myGlobalController;
  Rx<DateTime?> selectedDate = DateTime.now().obs;
  var cpf = TextEditingController();
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



  // faz a consulta na api, e completa os campos automaticamente

  @override
  void onInit() {
    myGlobalController = Get.find();
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
  List<Widget> gerarTextFields(context) {
      return [
        buildTextField('Nome completo', nome, context),
        buildTextField('CEP', cep, context, maxLength: 8,keyboard: 'number'),
        buildTextField('Estado', estado, context,maxLength:  2,ativated: false),
        buildTextField('Cidade', cidade, context,ativated: false),
        Obx(()=> buildTextField('Bairro', bairro,context, ativated: bairroAtivado.value)),
        Obx(()=> buildTextField('Rua', rua, context,ativated: ruaAtivado.value)),
        buildTextField('Numero', numero, context ,keyboard: 'number'),
        buildTextField('Telefone/com ddd', telefone,context, maxLength: 11),
        buildTextField('CPF', cpf,context, maxLength: 11),
        Obx(()=> buildDatePickerWidget(selectedDate,context))
      ];
    } 
  void toNextScreen(BuildContext context) {}
  }


class InsertUserDataPage extends StatelessWidget {
  InsertUserDataPage({Key? key}) : super(key: key);
  var insertUserDataPageController = Get.put(InsertUserDataPageController());
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: GetBuilder<InsertUserDataPageController>(
        init: InsertUserDataPageController(),
        builder: (_) {
          return Scaffold(
            body: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:const BoxDecoration(
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
                        const MyHeader(),
                        const SizedBox(height: 20,),
                        const Text('Insira suas Informações',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                        const SizedBox(height:5),
                        Expanded(
                            child: 
                            ListView(
                              children:
                                  insertUserDataPageController.gerarTextFields(context),
                            )
                          ),
                          
                          const SizedBox(height: 30,),
                          MyButton(
                            label: 'continuar',
                            borderRadius: BorderRadius.circular(50),
                            onPressed: (){
                    
                              var info = {
                                'Nome completo': insertUserDataPageController.nome.text,
                                'CEP': insertUserDataPageController.cep.text,
                                'Estado': insertUserDataPageController.estado.text,
                                'Cidade': insertUserDataPageController.cidade.text,
                                'Bairro': insertUserDataPageController.bairro.text,
                                'Rua' : insertUserDataPageController.rua.text,
                                'Numero': insertUserDataPageController.numero.text,
                                'Telefone': insertUserDataPageController.telefone.text,
                                'cpf': insertUserDataPageController.cpf.text,
                                'Data de nascimento': insertUserDataPageController.selectedDate.value,
                                'Data': true
                              };
                              validarCampos(info, context);
                              },

                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontColor:const Color.fromARGB(255, 61, 102, 159)
                          ),
                          const SizedBox(height: 30,),
                        
                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}



