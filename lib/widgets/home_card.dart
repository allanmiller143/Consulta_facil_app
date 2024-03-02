import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomeCardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String image;
  final RxString selected;
  

  const MyHomeCardButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.image,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Obx(() { 
            final isSelected = selected.value == label;
            return Column(
              children: [
                 
                   Material(
                    elevation: 5,
                    shadowColor: const  Color.fromARGB(255, 46, 118, 154),
                    borderRadius: BorderRadius.circular(150),
                    child: Container(
                      width:  MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        border: Border.all(width: 2,color:const Color.fromARGB(255, 255, 255, 255)),
                        image: DecorationImage(
                          image: AssetImage(image),
                          scale:  isSelected ? 1.2 :1.4
                        ),
                        gradient:const LinearGradient(
                          colors: [
                             Color.fromARGB(255, 133, 188, 221),
                             Color.fromARGB(255, 43, 61, 136),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                    
                        )
                      ),
                    ),
                  ), 
                const SizedBox(height: 10,),

                isSelected ? Text(label,style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 18,fontFamily: 'Nunito-VariableFont_wght',fontWeight: FontWeight.bold), ):  Text(label,style: const    TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontFamily: 'Nunito-VariableFont_wght',fontWeight: FontWeight.bold), )

              ],
            );
          }

        ),
      ),
    );
  }
}
