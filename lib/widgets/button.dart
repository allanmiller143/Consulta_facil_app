import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;


  const MyButton(
      {
        super.key,
        required this.label,
        required this.onPressed,
      });


  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(35,10,35,10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:const Color.fromARGB(222, 14, 114, 237)
          ),
          child: Text(label,style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
