import 'package:app_clinica/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyHeader extends StatelessWidget {
  const MyHeader(
    {super.key,}
  );


  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 130, 189, 223),
              borderRadius: BorderRadius.circular(120)
            ),
            child: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_rounded,color: Color.fromARGB(255, 255, 255, 255),)),
          ),
          Container(
            width: 150,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/imgs/logo.png'),fit: BoxFit.cover,scale: 1.2),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 130, 189, 223),
              borderRadius: BorderRadius.circular(120)
            ),
            child: IconButton(onPressed: (){showConfirmationDialog(context, 'info da tela ', 'escolha um tipo de serviço',);}, icon:const  Icon(Icons.info_outline,color: Color.fromARGB(255, 255, 255, 255),)),
          )
        ],
      ),
    );
  }
}
