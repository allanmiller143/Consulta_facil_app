// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MyProfileWidgetButton extends StatelessWidget {
  final Map<String,dynamic> info;

  final VoidCallback onPressed;

  const MyProfileWidgetButton(
      {
        super.key,
        required this.info,
        required this.onPressed,
        
      });


  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        ListTile(
          title: Text(info['title']!,style: const TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 20),),
          subtitle: Text(info['subtitle']!, style:const  TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 14,fontWeight: FontWeight.w200)),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Color.fromARGB(255, 255, 255, 255)),
          onTap: onPressed,
        ),
        const Divider(thickness: 2,),
      ],
    );
  
  }
}
