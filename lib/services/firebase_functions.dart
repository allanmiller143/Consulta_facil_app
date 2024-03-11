import 'package:firebase_auth/firebase_auth.dart';

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
