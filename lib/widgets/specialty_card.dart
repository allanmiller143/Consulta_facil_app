import 'package:app_clinica/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySpecialtyCardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  final String image;
  final String info;
  final RxString selected;
  

  const MySpecialtyCardButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.image,
    required this.info,
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
                  Stack(
                    children:[ 
                    Material(
                        elevation: 8,
                        shadowColor: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(250),
                        child: Container(
                          width:  MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(250),
                            border: Border.all(width: isSelected ? 3 : 2,color: isSelected ?const Color.fromARGB(255, 255, 255, 255) :const  Color.fromARGB(255, 0, 0, 0)),
                            image: DecorationImage(
                              image: AssetImage(image),
                              scale:  isSelected ? 1.2 :1.5
                        
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){
                            showConfirmationDialog(context, label, info);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.09,
                            height: MediaQuery.of(context).size.width *0.09,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color.fromARGB(255, 70, 118, 185) : const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(120)
                            ),
                            child: isSelected ? const Icon(Icons.info_rounded,color: Color.fromARGB(255, 255, 255, 255),) : const Icon(Icons.info_rounded,color: Color.fromARGB(255, 70, 118, 185),),
                          ),
                        ),
                      )
                    ]
                  ),
                const SizedBox(height: 10,),
                Text(label,style: const    TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 18,fontFamily: 'Nunito-VariableFont_wght',fontWeight: FontWeight.bold), )

              ],
            );
          }

        ),
      ),
    );
  }
}
