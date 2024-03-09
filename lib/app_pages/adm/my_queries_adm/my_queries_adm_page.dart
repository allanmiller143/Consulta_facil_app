import 'package:app_clinica/app_pages/adm/my_queries_adm/widgets/adm_query_widget.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/load_widget.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/dropDrown.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QueriesAdmPageController extends GetxController {
  List<Map<String, dynamic>> queryResults = [];
  late MyGlobalController myGlobalController;
  var selectedTypeSpecialty = "Especialidade".obs;
  var selectedTypeSpecialist = "Especialista".obs;
  List<Map<String, dynamic>> allSpecialist = [];
  Map<String, dynamic> allSpecialistNames = {};
  Map<String, dynamic> allSpecialtyNames = {};
  RxBool filted = false.obs;
  List<Map<String, dynamic>> filteredList = [];
  var search = TextEditingController();

  void collectListString() {
    allSpecialistNames.addAll({'Especialista': 'Especialista'});
    allSpecialistNames.addAll({'Todos': 'Todos'});
    for (var specialist in allSpecialist) {
      if (specialist.containsKey('Name')) {
        allSpecialistNames.addAll({'${specialist['Name']}': specialist['Name']});
      }
    }
  }

  void collectSpecialistNames() {
    allSpecialtyNames.addAll({'Especialidade': 'Especialidade'});
    allSpecialtyNames.addAll({'Todos': 'Todos'});
    for (var specialist in allSpecialist) {
      if (specialist.containsKey('Specialty') && !allSpecialistNames.containsKey('${specialist['Specialty']}')) {
        allSpecialtyNames.addAll({'${specialist['Specialty']}': specialist['Specialty']});
      }
    }
  }

  @override
  void onInit() async {
    myGlobalController = Get.find();
    allSpecialist = await myGlobalController.fetchDataFromApi('All_specialist');
    collectListString();
    collectSpecialistNames();
    super.onInit();
  }

  List<Widget> buildCards(BuildContext context) {
    List<Widget> cards = [];
    if (filteredList.isNotEmpty) {
      for (var item in filteredList) {
        cards.add(
        AdmQueryCard(item: item,)
        );
      }
    } else {
      cards.add(
        Center(child: const Text('Nenhum resultado encontrado.',style: TextStyle(color: Colors.white),)),
      );
    }

    return cards;
  }


  init() async {
    queryResults = [{}, {}];
    allSpecialist = await myGlobalController.fetchDataFromApi('Specialist');
    return queryResults;
  }
}

// ignore: must_be_immutable
class QueriesAdmPage extends StatelessWidget {
  QueriesAdmPage({Key? key}) : super(key: key);
  var queriesAdmPageController = Get.put(QueriesAdmPageController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<QueriesAdmPageController>(
        init: QueriesAdmPageController(),
        builder: (_) {
          return Scaffold(
            body: FutureBuilder(
              future: queriesAdmPageController.init(),
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
                            const Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                children: [
                                  MyHeader(),
                              
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                                  child: MySearchTextFormField(
                                    controller: queriesAdmPageController.search,
                                     onChanged: (){},
                                    
                                     color: Color.fromARGB(255, 61, 102, 159),
                                  ),
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor:Color.fromARGB(255, 26, 60, 123),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      builder: (BuildContext context) {
                                        return BottomSheetContent(myController: queriesAdmPageController);
                                      },
                                    );
                                  },
                                  child: const Text('filtrar consultas ', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(0, 255, 255, 255),
                                  border: Border(
                                    top: BorderSide(color: Colors.white),
                                  ),
                                
                                ),
                                child: Obx(
                                  () => queriesAdmPageController.filted.value
                                      ? ListView(
                                          children: queriesAdmPageController.buildCards(context),
                                        )
                                      : ListView(
                                          children: queriesAdmPageController.buildCards(context),
                                        ),
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar a lista ${snapshot.error}');
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final QueriesAdmPageController myController;

  const BottomSheetContent({super.key, required this.myController});

  void returnList(context) async {
    myController.filteredList.clear();
    if (myController.selectedTypeSpecialist.value == 'Todos' || myController.selectedTypeSpecialty.value == 'Todos') {
      showLoad(context);
      var fetchedData = await myController.myGlobalController.fetchDataFromApi('Consultas');
      Get.back();
      if (fetchedData.isNotEmpty) {
        myController.filteredList.addAll(fetchedData);
      }
    }
    myController.filted.value = !myController.filted.value;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleTextStyle = const TextStyle(fontSize: 18,color: Color.fromARGB(255, 245, 245, 245),fontWeight: FontWeight.bold);
    TextStyle listTileTextStyle = const TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold);
    TextStyle listTileSubtitleTextStyle = const TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w200);

    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExpansionTile(
            title: Text('Especialidade', style: titleTextStyle),
            iconColor: const Color.fromARGB(255, 255, 255, 255),
            collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: CustomDropdownButton(
                  items: myController.allSpecialtyNames,
                  controller: myController.selectedTypeSpecialty,
                  label: 'Selecione a especialidade',
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text('Especialista', style: titleTextStyle),
            iconColor: const Color.fromARGB(255, 255, 255, 255),
            collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: CustomDropdownButton(
                  items: myController.allSpecialistNames,
                  controller: myController.selectedTypeSpecialist,
                  label: 'Selecione a especialidade',
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text('Status', style: titleTextStyle),
            iconColor: const Color.fromARGB(255, 255, 255, 255),
            collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
            children: <Widget>[
              ListTile(
                title: Text('Aberta', style: listTileTextStyle),
                subtitle: Text('Consultas que não foram finalizadas', style: listTileSubtitleTextStyle),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Finalizada', style: listTileTextStyle),
                subtitle: Text('Consultas que já foram finalizadas', style: listTileSubtitleTextStyle),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Dia/Mês/ano', style: titleTextStyle),
            iconColor: const Color.fromARGB(255, 255, 255, 255),
            collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
            children: <Widget>[
              Text('Ainda não implementado', style: titleTextStyle),
            ],
          ),
          MyButton(label: 'Filtrar', borderRadius: BorderRadius.circular(50),  onPressed: (){ returnList(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
          SizedBox(height: 10,)
        ],
      
    );
  }
}


