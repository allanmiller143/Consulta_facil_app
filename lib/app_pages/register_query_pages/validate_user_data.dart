import 'package:app_clinica/controller/globalController.dart';
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
    cep = cep.replaceAll(
        RegExp(r'\D'), ''); // Remove caracteres não numéricos do CEP
    // Verifica se o CEP tem 8 dígitos
    if (cep.length != 8) {
      return false;
    }
    return true; // O CEP é válido
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



 void validarCampos(Map<String,dynamic> info,context) async{
    if(info['Nome completo'].isEmpty || info['CEP'].isEmpty || info['Estado'].isEmpty || info['Cidade'].isEmpty || info['Bairro'].isEmpty || info['Rua'].isEmpty || info['Numero'].isEmpty|| info['Telefone'].isEmpty || info['cpf'].isEmpty){
      showConfirmationDialog(context, 'Alerta', 'Por favor, preencha todos os campos para prosseguir!');
    }else{
      String mensagemRetorno = 'Campos ínvalidos:\n';
      if(!validateCPF(info['cpf'])){ // aqui verificar se o cpf existe
        mensagemRetorno = '${mensagemRetorno}cpf\n';
      }
      if(!validarTelefone(info['Telefone'])){
        mensagemRetorno = '${mensagemRetorno}telefone\n';
      }
      if(!validarCEP(info['CEP'])){
        mensagemRetorno = '${mensagemRetorno}CEP\n';
      }

      // ainda precisa validar cpf no banco de dados
     
      if(mensagemRetorno == 'Campos ínvalidos:\n'){
        
        Map<String,dynamic> data = {
          'Nome completo': info['Nome completo'],
          'CEP': info['CEP'],
          'Estado': info['Estado'],
          'Cidade': info['Cidade'],
          'Bairro': info['Bairro'],
          'Rua' : info['Rua'],
          'Numero': info['Numero'],
          'Telefone': info['Telefone'],
          'cpf': info['cpf'],
          'Data de Nascimento': info['Data de Nascimento'],
          'Data': true    
        };
        showConfirmationDialogFunction(context, 'Sucesso', 'Dados cadastrados com sucesso!\n\n Agora voce pode agendar uma consulta.' ,(){ Get.back();Get.back();});
        MyGlobalController myGlobalController = Get.find();
        myGlobalController.userInfo2.addAll(data);


         
      }else {
        showConfirmationDialog(context, 'Alerta', mensagemRetorno);
  
      }
      
    }

  }