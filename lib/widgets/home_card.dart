import 'package:flutter/material.dart';

class MyHomeCardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String image;

  const MyHomeCardButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.40,
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              
            ),
            child: 
                Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    decoration: BoxDecoration(
                      color:const  Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                      borderRadius:  BorderRadius.circular(10),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                
              
          ),
        ),
      ),
    );
  }
}
