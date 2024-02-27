// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfilePageController extends GetxController {

}



class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  var profilePageController = Get.put(ProfilePageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<ProfilePageController>(
        init: ProfilePageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(22, 166, 151, 1),
            body: Stack(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 40,left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Seja bem-vindo \nAllan Miller!',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: const Color.fromARGB(255, 255, 255, 255),fontSize: 23,fontWeight: FontWeight.w900 ),),
                      SizedBox(height: 5,),
                      Text('Explore na sua clínica favorita',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: const Color.fromARGB(255, 255, 255, 255),fontSize: 15,fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 160),
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(35)),
                      color: const Color.fromARGB(255, 255, 255, 255)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25,20,25,0),
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
