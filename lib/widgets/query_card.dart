
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyQueryButton extends StatelessWidget {
  final Map<String, dynamic> info;
  final VoidCallback onPressed;


  const MyQueryButton({
    Key? key,
    required this.info,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String dateInfo = '${DateFormat.yMMMMd('pt_BR').format(info['Date'].toLocal())} ás ${DateFormat.Hm('pt_BR').format(info['Date'].toLocal())}';
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: ListTile(
            title: Text(info['Specialty'],style: const TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 20),),
            subtitle: Text(dateInfo,style: const TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 14,fontWeight: FontWeight.w200)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Color.fromARGB(255, 255, 255, 255)),
            onTap: onPressed,
        
          )
        ),
        const Padding(
          padding:  EdgeInsets.fromLTRB(15,0,15,0),
          child: Divider(),
        )
      ],
    );
  }
}


class MyEditQueryButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;


  const MyEditQueryButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: ListTile(
            title: Text(title,style: const TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 18),),
            subtitle: Text(subtitle,style: const TextStyle(color:  Color.fromARGB(255, 255, 255, 255),fontSize: 12,fontWeight: FontWeight.w200)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,color: Color.fromARGB(255, 255, 255, 255)),
            onTap: onPressed,
        
          )
        ),
        const Padding(
          padding:  EdgeInsets.fromLTRB(15,0,15,0),
          child: Divider(),
        )
      ],
    );
  }
}