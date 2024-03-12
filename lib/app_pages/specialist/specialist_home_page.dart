  // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
  import 'package:app_clinica/configs/controllers/globalController.dart';
  import 'package:app_clinica/configs/default_pages/loading_page.dart';
  import 'package:app_clinica/widgets/header.dart';
  import 'package:app_clinica/widgets/home_card.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  class SpecialistHomePageController extends GetxController {
      late MyGlobalController myGlobalController;

      @override
      void onInit() {
        super.onInit();
        myGlobalController = Get.find();
      }
      
      init() async {
       
        return 'aysf';
      }

      RxString selected = ''.obs;
  }

  class SpecialistHomePage extends StatelessWidget {
      SpecialistHomePage({Key? key}) : super(key: key);
      var homePageController = Get.put(SpecialistHomePageController());

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: GetBuilder<SpecialistHomePageController>(
            init: SpecialistHomePageController(),
            builder: (_) {
              return Scaffold(
                body: FutureBuilder(
                  future: homePageController.init(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return 
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 15, 39, 108),
                                  Color.fromARGB(255, 6, 18, 42),
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
                                  Column(
                                    children: [
                                      Text(
                                        'Bem-vindo',
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                        ),
                                      ),
                                      Text(
                                        homePageController.myGlobalController.userInfo['specialist'],
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      MyHomeCardButton(
                                        selected: homePageController.selected,
                                        label: 'Minhas consultas',
                                        onPressed: () {
                                          Get.toNamed('/specialist_queries');
                                        },
                                        image: 'assets/imgs/minhasConsultas.png',
                                      ),
                                      MyHomeCardButton(

                                        selected: homePageController.selected,
                                        label: 'Perfil',
                                        onPressed: () {
                                          Get.toNamed('/specialist_profile');

                                        },
                                        image: 'assets/imgs/perfil.png',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                      }else{
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      } else if (snapshot.hasError) {
                        return Text('Erro ao carregar a lista ${snapshot.error}');
                      } else {
                      return LoadingWidget();
                      }
                  }
                ),
              );
            },
          ),
        );
      }
  }



