// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls
import 'package:app_clinica/app_pages/user/register_query_pages/select_specialty_page.dart';
import 'package:app_clinica/configs/controllers/globalController.dart';
import 'package:app_clinica/configs/default_pages/loading_page.dart';
import 'package:app_clinica/configs/default_pages/try_again_page.dart';
import 'package:app_clinica/services/api.dart';
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectDoctorPageController extends GetxController {
  var search = TextEditingController();
  RxString selected = ''.obs;
  var selectDoctorInfo;
  RxBool searchBar = false.obs;
  var data;
  late MyGlobalController myGlobalController;
  var queryResult = [];
  late SelectSpecialtyPageController selectSpecialtyPageController;



  List<Widget> buildWidgets(context,data) {
    List<Widget> rows = [];
      for (int i = 0; i < data.length; i += 2) {
        List<Widget> rowChildren = [];
        rowChildren.add(
          MySpecialtyCardButton(
            selected: selected,
            label: data[i]['specialist'],
            onPressed: () {
              selected.value = data[i]['specialist'];
              selectDoctorInfo = data[i];
            },
            //image: data[i]['imageAsset'],
            info: data[i]['description'],
            image: 'assets/imgs/Cardiologista.png',

          ),
        );

        // Adicione o segundo item da linha se existir
        if (i + 1 < data.length) {
          rowChildren.add(
            MySpecialtyCardButton(
              selected: selected,
              label: data[i + 1]['specialist'],
              onPressed: () {
                selected.value = data[i + 1]['specialist'];
                selectDoctorInfo = data[i + 1];
              },
              //image: data[i + 1]['imageAsset'],
              image: 'assets/imgs/Cardiologista.png',
              info: data[i + 1]['description'],
            
            ),
          );
        }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowChildren,
        ),
      );
     }
    return rows;   
  } 
  
  void toNextScreen(context){
    if(selected.value == ''){
      showConfirmationDialog(context, 'Alerta', 'Por favor, selecione um especialista para proceguir para a proxima etapa! ');
    }
    else{
      MyGlobalQueryController myGlobalQueryController = Get.find();
      myGlobalQueryController.specialist = selected.value;
      myGlobalQueryController.crm = selectDoctorInfo['crm'];
      Get.toNamed('/date');
    }
  }
  
  initialSearch(value) {
      if (value.length != 0 && queryResult.isEmpty) {
        var capitalizedvalue = value[0].toUpperCase() + value.substring(1);
        searchBar.value = true;
        for(var x in data){
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

  init() async {
    data = await searchApi('specialist/${selectSpecialtyPageController.selected.value}');
    return data;
  }

  @override
  void onInit(){
    selectSpecialtyPageController = Get.find();
      myGlobalController = Get.find();
      super.onInit();
    }
}

class SelectDoctorPage extends StatelessWidget {
  SelectDoctorPage({Key? key}) : super(key: key);
  var selectDoctorPageController = Get.put(SelectDoctorPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SelectDoctorPageController>(
        init: SelectDoctorPageController(),
        builder: (_) {
          return Scaffold(
            body: FutureBuilder(
              future: selectDoctorPageController.init(),
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
                            MySearchTextFormField(controller: selectDoctorPageController.search,color: Color.fromARGB(255, 61, 102, 159),onChanged: (){ selectDoctorPageController.initialSearch(selectDoctorPageController.search.text);}),
                            SizedBox(height: 20,),
                            Text('Selecione um especilaista',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 )),
                            SizedBox(height:5),
                            Expanded(
                                child: 
                                Obx(
                                  ()=> selectDoctorPageController.searchBar.value?
                                  ListView(
                                    children:
                                        selectDoctorPageController.buildWidgets(context,selectDoctorPageController.queryResult),
                                  ):
                                  ListView(
                                    children:
                                        selectDoctorPageController.buildWidgets(context,selectDoctorPageController.data),
                                  )
                                )
                              ),
                              SizedBox(height: 30,),
                              MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){selectDoctorPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                              SizedBox(height: 30,),
                            
                          ],
                        ),
                      ),
                    );
                   }else{
                    return Center(child: Text(snapshot.error.toString()));
                   }
                  } else if (snapshot.hasError) {
                    return TryAgainPage();
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



