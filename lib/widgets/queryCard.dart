import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyQueryButton extends StatelessWidget {
  final Map<String,dynamic> info;
  final VoidCallback onPressed;
  final String image;
  final RxString selected;
  

  const MyQueryButton({
    Key? key,
    required this.info,
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
        child: Column(
              children: [
                   Material(
                    elevation: 5,
                    shadowColor: const  Color.fromARGB(255, 46, 118, 154),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 0.5,color:const Color.fromARGB(255, 255, 255, 255)),
                        
                        gradient:const LinearGradient(
                          colors: [
                             Color.fromARGB(255, 133, 188, 221),
                             Color.fromARGB(255, 43, 61, 136),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                    
                        )
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(5,5,5,5),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: double.infinity,
                            decoration:const  BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only( 
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                              )
                            ),
                          ),
                       Container(
  width: 50,
  color: Colors.black,
  child: Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq',
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Defina o número máximo de linhas desejado
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  ),
),
                        
                          
                        ]
                      ),
                    ),
                  ), 
                const SizedBox(height: 10,),
                const Text('label',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontFamily: 'Nunito-VariableFont_wght',fontWeight: FontWeight.bold), )

              ],
            )
      )
    );
        

  }
}
