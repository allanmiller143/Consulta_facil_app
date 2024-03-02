import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double heigth;
  final BorderRadius borderRadius;
  final Color color;
  final Color fontColor;


  const MyButton(
      {
        super.key,
        required this.label,
        required this.onPressed,
        this.width = 150,
        this.heigth = 50,
        this.borderRadius = const BorderRadius.all(Radius.circular(10)),
        this.color = const Color.fromARGB(222, 14, 114, 237),
        this.fontColor = const Color.fromARGB(222, 255, 255, 255)
      });


  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: width,
          height: heigth,
          padding: const EdgeInsets.fromLTRB(20,10,20,10),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color:color
          ),
          child: Center(child: Text(label,style: TextStyle( color: fontColor,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
      ),
    );
  }
}
