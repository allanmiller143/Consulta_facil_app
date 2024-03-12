import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/profile_widget.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSpecialistPageController extends GetxController {
  var specialistResults;
  Map<String,dynamic> currentSpecialist = {};
  late MyGlobalController myGlobalController;
  var search = TextEditingController();
  RxBool searchBar = false.obs;
  var queryResult = [];


  
  @override
  void onInit() {
    myGlobalController = Get.find();
    super.onInit();
  }
  

  initialSearch(value) {
    if (value.length != 0 && queryResult.isEmpty) {
      var capitalizedvalue = value[0].toUpperCase() + value.substring(1);
      searchBar.value = true;
      for(var x in specialistResults){
        if(x['search'].toString().startsWith(capitalizedvalue)){
          queryResult.add(x);
        }
      }
      
    }
    else if(value.length == 0){
      queryResult = [];
      searchBar.value = false;
    }
  }


  List<Widget> buildCards(context, list) {
    List<Widget> cards = [];
    for(int i = 0;i<list.length;i++){
      cards.add(
        MyProfileWidgetButton(
          info: {
            'title': list[i]['specialist'],
            'subtitle': '${list[i]['specialty']}, ${list[i]['crm']}',
          },
          onPressed: (){
            currentSpecialist = list[i];
            Get.toNamed('/select_specialist_update_type');
          }
        )
        );

    } 
    return cards;
  }
  
  init() async {
    specialistResults = await searchApi('doctor');
    return specialistResults;
  }

}

// ignore: must_be_immutable
class ListSpecialistPage extends StatelessWidget {
  ListSpecialistPage({Key? key}) : super(key: key);
  var listSpecialistPageController = Get.put(ListSpecialistPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<ListSpecialistPageController>(
        init: ListSpecialistPageController(),
        builder: (_) {
          return Scaffold( 
            body: FutureBuilder(
              future: listSpecialistPageController.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const   EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                children: [
                                  const MyHeader(),
                                  const SizedBox( height: 15),
                                  MySearchTextFormField(controller: listSpecialistPageController.search,color: Color.fromARGB(255, 61, 102, 159),onChanged: (){ listSpecialistPageController.initialSearch(listSpecialistPageController.search.text);}),
                              
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,), 
                                child: Obx(()=>
                                  listSpecialistPageController.searchBar.value?
                                  ListView(
                                    children: listSpecialistPageController.buildCards(context, listSpecialistPageController.queryResult),
                                  ):
                                  ListView(
                                    children: listSpecialistPageController.buildCards(context, listSpecialistPageController.specialistResults),
                                  )
                                ),
                              )
                            ),
                            const SizedBox(height: 30),
                          
                            const SizedBox(height: 30),
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
                  return const LoadingWidget();
                  }
              }
            ),
          );
        },
      ),
    );
  }
}




