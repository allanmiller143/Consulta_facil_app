import 'package:app_clinica/configs/controllers/globalController.dart';
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

  bool validarCEP(String cep) {
    cep = cep.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos do CEP
    // Verifica se o CEP tem 8 dígitos
    if (cep.length != 8) {
      return false;
    }
    return true; // O CEP é válido
  }

  bool validarTelefone(String telefone) {
    telefone = telefone.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos do telefone

    // Verifica se o CEP tem 8 dígitos
    if (telefone.length != 11) {
      return false;
    }
    return true; // O telefone é válido
  }
 
 void validarCampos(Map<String,dynamic> info,context) async{
    if(info['name'].isEmpty || info['cep'].isEmpty || info['state'].isEmpty || info['city'].isEmpty || info['neighborhood'].isEmpty || info['address'].isEmpty || info['house_number'].isEmpty|| info['phone'].isEmpty || info['cpf'].isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
      String mensagemRetorno = 'Campos ínvalidos:\n';
      if(!validateCPF(info['cpf'])){ // aqui verificar se o cpf existe
        mensagemRetorno = '${mensagemRetorno}cpf\n';
      }
      if(!validarTelefone(info['phone'])){
        mensagemRetorno = '${mensagemRetorno}telefone\n';
      }
      if(!validarCEP(info['cep'])){
        mensagemRetorno = '${mensagemRetorno}CEP\n';
      }

      // ainda precisa validar cpf no banco de dados

     
      if(mensagemRetorno == 'Campos ínvalidos:\n'){

        showConfirmationDialogFunction(context, 'Sucesso', 'Dados cadastrados com sucesso!\n\n Agora voce pode agendar uma consulta.' ,(){ Get.back();Get.back();});
        MyGlobalController myGlobalController = Get.find();
        myGlobalController.userInfo.addAll(info);


         
      }else {
        showConfirmationDialog(context, 'Alerta', mensagemRetorno);
  
      }
      
    }

  }