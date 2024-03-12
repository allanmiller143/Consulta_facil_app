import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

Future<void> deleteFirebaseUser(String email) async {
  try {
    // Buscar o usuário pelo e-mail
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: 'senha_qualquer', // Forneça uma senha válida para autenticar temporariamente
    );

    // Excluir o usuário
    await userCredential.user?.delete();

    print('Usuário excluído com sucesso do Firebase Authentication.');
  } catch (error) {
    print('Erro ao excluir o usuário do Firebase Authentication: $error');
  }
}



Future<bool> registerUserWithEmailAndPassword(String email,context) async {
  try {
    showLoad(context);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: 'consulta_123',
    );
    Get.back();
    return true;
  } catch (error) {
    Get.back();
    return false;
  }
  
}

