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
    required this.selected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Obx(() { 
            final isSelected = selected.value == label;
            return Material(
            elevation: 4,
            shadowColor:  Colors.black,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                border: !isSelected?  null:Border.all(color:const  Color.fromARGB(255, 18, 141, 255),width: 1)
                
              ),
              child: 
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      decoration: BoxDecoration(
                        color:const  Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                        borderRadius:  BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontFamily: 'Nunito-VariableFont_wght',
                              fontWeight: FontWeight.w600,
                              fontSize:  isSelected ? 29 : 22,
                              color:  const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          IconButton(onPressed: (){showConfirmationDialog(context, label, info);}, icon:const  Icon(Icons.info_outline,color: Color.fromARGB(255, 255, 255, 255),))
                        ],
                      ),
                    ),
            ),
          );
          }

        ),
      ),
    );
  }
}
