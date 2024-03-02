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
    Row(
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
          width: 250,
          height: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/imgs/logo.png'),fit: BoxFit.cover,),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 130, 189, 223),
            borderRadius: BorderRadius.circular(120)
          ),
          child: IconButton(onPressed: (){showConfirmationDialog(context, 'info da tela ', 'escolha um tipo de serviço',);}, icon: Icon(Icons.info_outline,color: Color.fromARGB(255, 255, 255, 255),)),
        )
      ],
    );
  }
}
