// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/home_card.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePageController extends GetxController {
  static HomePageController get to => Get.find(); 
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
            backgroundColor:  Color.fromARGB(222, 14, 114, 237),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40,left: 30,right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Seja bem-vindo \nAllan Miller!',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: const Color.fromARGB(255, 255, 255, 255),fontSize: 23,fontWeight: FontWeight.w900 ),),
                        ] 
                        ,
                      ),
                      SizedBox(height: 5,),
                      Text('Explore na sua clínica favorita',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: const Color.fromARGB(255, 255, 255, 255),fontSize: 15,fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 160),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(35)),
                      color: const Color.fromARGB(255, 255, 255, 255)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,20,25,0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Vamos lá!',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: Color.fromARGB(222, 14, 114, 237),fontSize: 23,fontWeight: FontWeight.w900 ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyHomeCardButton(label: 'Agendar\nconsulta', onPressed: (){},image: 'assets/imgs/agendar.png'),
                              MyHomeCardButton(label: 'Seu perfil', onPressed: (){Get.toNamed('/profile');},image: 'assets/imgs/perfil.png'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyHomeCardButton(label: 'Minhas\nconsultas', onPressed: (){},image: 'assets/imgs/minhasConsultas.png'),
                              MyHomeCardButton(label: 'Notificações', onPressed: (){},image: 'assets/imgs/notificacoes.png'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              
              ],
            ),
          );
        },
      ),
    );
  }
}
