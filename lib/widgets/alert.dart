
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showConfirmationDialog(context,title,content,) {
    showDialog(
      context: context,
      useSafeArea: true,
      
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:const Color.fromARGB(255, 255, 255, 255),
          title:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 15, 39, 108),fontFamily: 'Nunito-VariableFont_wght'),),
          content: Text(content,style:const  TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
             
              },
              child: const Text('Fechar',style: TextStyle(color: Color.fromARGB(255, 15, 39, 108)),),
            ),
          ],
        );
      },
    );
  }


void showConfirmationDialogFunction(context, title, content, onPressed) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Adiciona a lógica desejada quando o usuário toca fora do diálogo
          onPressed();
          return true;
        },
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 114, 237),
              fontFamily: 'Nunito-VariableFont_wght',
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'Continuar',
                style: TextStyle(color: Color.fromARGB(255, 14, 114, 237)),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showConfirmationDialogFunction2(context, title, content, onPressed) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 114, 237),
              fontFamily: 'Nunito-VariableFont_wght',
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            TextButton(
              onPressed: (){Get.back();},
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color.fromARGB(255, 14, 114, 237)),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'Continuar',
                style: TextStyle(color: Color.fromARGB(255, 14, 114, 237)),
              ),
            ),
          ],
        );
  
    },
  );
}
