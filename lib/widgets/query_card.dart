
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
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Material(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 46, 118, 154),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: const Color.fromARGB(255, 255, 255, 255)),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: double.infinity,
                      decoration:  BoxDecoration(
                        color: const Color.fromARGB(255, 25, 117, 148),
                        image: DecorationImage(image: AssetImage(info['Image'],),scale: 1.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin:const EdgeInsets.fromLTRB(0, 5, 2, 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child:  Text(
                                 info['Specialty'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 0.001),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child:  Text(
                                  DateFormat.yMMMMd('pt_BR').format( info['Date'].toLocal()),
                                
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style:const  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  info['Specialist'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style:const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.001),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    decoration: BoxDecoration(
                                      color:const Color.fromARGB(255, 25, 95, 151),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Editar',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding:const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 193, 16, 16),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Cancelar',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}