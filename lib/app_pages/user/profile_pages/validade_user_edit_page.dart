import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:get/get.dart';

bool validateCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
   
    if (cpf.length != 11) {
      return false;
    }
    
    if (RegExp(r'^(\d)\1+$').hasMatch(cpf)) {
      return false;
    }

    // Calcula o primeiro dígito verificador
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int digito1 = (soma * 10) % 11;

    if (digito1 == 10) {
      digito1 = 0;
    }

    if (digito1 != int.parse(cpf[9])) {
      return false;
    }

    // Calcula o segundo dígito verificador
    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int digito2 = (soma * 10) % 11;

    if (digito2 == 10) {
      digito2 = 0;
    }

    return digito2 == int.parse(cpf[10]);
  }


  bool validarTelefone(String telefone) {
    telefone = telefone.replaceAll(
        RegExp(r'\D'), ''); // Remove caracteres não numéricos do telefone
    // Verifica se o CEP tem 8 dígitos
    if (telefone.length != 11) {
      return false;
    }
    return true; // O teelfone é válido
  }

 void validarCamposEdit(Map<String,dynamic> info,context) async{
    MyGlobalController myGlobalController = Get.find();
    if(info['name'].isEmpty || info['phone'].isEmpty || info['cpf'].isEmpty || info['email'].isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
      String returnMessege = 'Campos ínvalidos:\n';
      if(!validateCPF(info['cpf'])){ // aqui verificar se o cpf existe
        returnMessege = '${returnMessege}cpf\n';
      }
      if(!validarTelefone(info['phone'])){
        returnMessege = '${returnMessege}telefone\n';
      }
      // ainda precisa validar cpf no banco de dados
      if(returnMessege == 'Campos ínvalidos:\n'){
        
        myGlobalController.userInfo.addAll(info);

        info['email'] = myGlobalController.userInfo['email'];
        info['data'] = myGlobalController.userInfo['data'];
        info['token'] = myGlobalController.userInfo['token'];
        info['user_type'] = myGlobalController.userInfo['user_type'];
        info['birth_date'] = info['birth_date']?.toIso8601String(); 

        showLoad(context);
        
        await updateApi('user/${myGlobalController.userInfo['email']}', info);
        Get.back();
        showConfirmationDialogFunction(context, 'Sucesso', 'Dados Aletrados com sucesso!' ,(){ Get.back();Get.back();});
        
        


         
      }else {
        showConfirmationDialog(context, 'Alerta', returnMessege);
  
      }
    }
  }

  void validateEditAddress(Map<String,dynamic> info,context) async{
    MyGlobalController myGlobalController = Get.find();

    showLoad(context);
    if(info['cep'].isEmpty || info['city'].isEmpty || info['neighborhood'].isEmpty || info['adrress'].isEmpty || info['house_number'].isEmpty){
      Get.back();
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
        Map<String,dynamic> data = {
          'email': myGlobalController.userInfo['email'],
          'data': myGlobalController.userInfo['data'],
          'token': myGlobalController.userInfo['token'],
          'user_type': myGlobalController.userInfo['user_type'],
          'cep': info['cep'],
          'state': info['state'],
          'city': info['city'],
          'neighborhood': info['neighborhood'],
          'street' : info['address'],
          'house_number': info['house_number'],
        };
        await updateApi('user/${myGlobalController.userInfo['email']}', data);
        myGlobalController.userInfo.addAll(data);
        Get.back();
        showConfirmationDialogFunction(context, 'Sucesso', 'Dados Aletrados com sucesso!' ,(){ Get.back();Get.back();});
        
    }

  }