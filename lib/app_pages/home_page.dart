// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/home_card.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePageController extends GetxController {
  
  RxString selected = ''.obs;
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (_) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 77, 136, 213),
                    Color.fromARGB(255, 7, 24, 58),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: Column(
                  children: [
                    MyHeader(),
                    Text('Bem-vindo',style: TextStyle(fontSize: 26,color: const Color.fromARGB(255, 255, 255, 255),),),
                    SizedBox(height: 15),
                    
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MyHomeCardButton(
                                  selected: homePageController.selected,
                                  label: 'Minhas consultas',
                                  onPressed: () {
                                    Get.toNamed('/queries');
                                    
                                  },
                                  image: 'assets/imgs/minhasConsultas.png',
                                 
                                ),
                                MyHomeCardButton(
                                  selected: homePageController.selected,
                                  label: 'Agendar consulta',
                                  onPressed: () {
                                    Get.toNamed('/agendar');
                                    
                                  },
                                  image: 'assets/imgs/agendar.png',
                                 
                                ),
                              ],
                            ),
                        
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyHomeCardButton(
                              selected: homePageController.selected,
                              label: 'Notificações',
                              onPressed: () {
                                
                                
                              },
                              image: 'assets/imgs/notificacoes.png',
                             
                            ),
                            MyHomeCardButton(
                              selected: homePageController.selected,
                              label: 'Perfil',
                              onPressed: () {
                                
                              },
                              image: 'assets/imgs/perfil.png',
                              
                            ),
                          ],
                        ),
                        
                                
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
