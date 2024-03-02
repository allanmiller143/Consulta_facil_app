
import 'package:flutter/material.dart';

void showConfirmationDialog(context,title,content,) {
    showDialog(
      context: context,
      useSafeArea: true,
      
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor:const Color.fromARGB(255, 255, 255, 255),
          title:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 14, 114, 237),fontFamily: 'Nunito-VariableFont_wght'),),
          content: Text(content,style:const  TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
             
              },
              child: const Text('Fechar',style: TextStyle(color: Color.fromARGB(255, 14, 114, 237)),),
            ),
          ],
        );
      },
    );
  }


  void showConfirmationDialogFunction(context,title,content,onPressed) {
    showDialog(
      context: context,
      useSafeArea: true,
      
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor:const Color.fromARGB(255, 255, 255, 255),
          title:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 14, 114, 237),fontFamily: 'Nunito-VariableFont_wght'),),
          content: Text(content,style:const  TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('Fechar',style: TextStyle(color: Color.fromARGB(255, 14, 114, 237)),),
            ),
          ],
        );
      },
    );
  }