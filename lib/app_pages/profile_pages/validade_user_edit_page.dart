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
    if(info['Nome completo'].isEmpty || info['Telefone'].isEmpty || info['cpf'].isEmpty || info['E-mail'].isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
      String mensagemRetorno = 'Campos ínvalidos:\n';
      if(!validateCPF(info['cpf'])){ // aqui verificar se o cpf existe
        mensagemRetorno = '${mensagemRetorno}cpf\n';
      }
      if(!validarTelefone(info['Telefone'])){
        mensagemRetorno = '${mensagemRetorno}telefone\n';
      }
      // ainda precisa validar cpf no banco de dados
      if(mensagemRetorno == 'Campos ínvalidos:\n'){
        
       
        showConfirmationDialogFunction(context, 'Sucesso', 'Dados Aletrados com sucesso!' ,(){ Get.back();Get.back();});
        MyGlobalController myGlobalController = Get.find();
        myGlobalController.userInfo.addAll(info);


         
      }else {
        showConfirmationDialog(context, 'Alerta', mensagemRetorno);
  
      }
    }
  }

  void validateEditAddress(Map<String,dynamic> info,context) async{
    if(info['CEP'].isEmpty || info['Cidade'].isEmpty || info['Bairro'].isEmpty || info['Rua'].isEmpty || info['Numero'].isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
        Map<String,dynamic> data = {
          'CEP': info['CEP'],
          'Estado': info['Estado'],
          'Cidade': info['Cidade'],
          'Bairro': info['Bairro'],
          'Rua' : info['Rua'],
          'Numero': info['Numero'],
        };
        showConfirmationDialogFunction(context, 'Sucesso', 'Dados Aletrados com sucesso!' ,(){ Get.back();Get.back();});
        MyGlobalController myGlobalController = Get.find();
        myGlobalController.userInfo.addAll(data);
    }

  }