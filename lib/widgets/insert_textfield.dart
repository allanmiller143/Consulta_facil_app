


import 'package:app_clinica/app_pages/user/profile_pages/edit_info_page.dart';
import 'package:app_clinica/app_pages/user/register_query_pages/insert_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTextField(String text, TextEditingController controller, BuildContext context, {String keyboard = 'text' ,int maxLength = 1, bool ativated = true,int type = 0}) {
  

  return Padding(
    padding: maxLength == 1 ? const EdgeInsets.fromLTRB(0, 0, 0, 16) : const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        TextFormField(
          onChanged: (value) async {
            if (text == 'CEP' && value.length == 8) {
              if(type == 0){
                InsertUserDataPageController insertUserDataPageController = Get.find();
                await insertUserDataPageController.completeCep(insertUserDataPageController.cep.text, context);
              }else{
                EditProfilePageController editProfilePageController = Get.find();
                await editProfilePageController.completeCep(editProfilePageController.cep.text, context);
              }    
            }
          },
          keyboardType: keyboard == 'text' ? TextInputType.text : TextInputType.number,
          maxLength: maxLength == 1 ? null : maxLength,
          enabled: ativated,
          controller: controller,
          decoration: InputDecoration(
            
            counterStyle: const TextStyle(color: Colors.white), // Define a cor do contador de caracteres
            fillColor: ativated?  const Color.fromARGB(255, 255, 255, 255) : const  Color.fromARGB(197, 240, 240, 240), // Adicione esta linha para definir a cor de fundo
            filled: true, // Garante que o campo esteja preenchido com a cor de fundo
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
            contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {
                controller.clear();
              },
            ),
          ),
        ),
      ],
    ),
  );
}