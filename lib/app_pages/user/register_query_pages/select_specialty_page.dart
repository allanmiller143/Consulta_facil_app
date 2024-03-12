// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
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


class SelectSpecialtyPageController extends GetxController {
  late MyGlobalController myGlobalController;
  RxBool barraDePesquisa = false.obs;
  var queryResultado = [];
  var dados;
  var search = TextEditingController();
  RxString selected = ''.obs;

  List<Widget> buildWidgets(context,dados) {
      List<Widget> rows = [];
        for (int i = 0; i < dados.length; i += 2) {
          List<Widget> rowChildren = [];
          rowChildren.add(
            MySpecialtyCardButton(
              selected: selected,
              label: dados[i]['specialty'],
              onPressed: () {
                selected.value = dados[i]['specialty'];
              },
              image: 'assets/imgs/Cardiologista.png',
              info: 'teste',
            ),
          );

          // Adicione o segundo item da linha se existir
          if (i + 1 < dados.length) {
            rowChildren.add(
              MySpecialtyCardButton(
                selected: selected,
                label: dados[i + 1]['specialty'],
                onPressed: () {
                  selected.value = dados[i + 1]['specialty'];
                },
                //image: dados[i + 1]['imageAsset'],
                //info: dados[i + 1]['content'],
                image: 'assets/imgs/Cardiologista.png',
                info: 'teste',
              
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
      showConfirmationDialog(context, 'Alerta', 'Por favor, selecione uma especialidade para proceguir para a proxima etapa! ');
    }
    else{
      MyGlobalQueryController myGlobalQueryController = Get.find();
      myGlobalQueryController.specialty = selected.value;
      Get.toNamed('/doctor');
    }
  }

  buscaInicial(valor) {
    if (valor.length != 0 && queryResultado.isEmpty) {
      var capitalizedValor = valor[0].toUpperCase() + valor.substring(1);
      barraDePesquisa.value = true;
      for(var x in dados){
        if(x['specialty'].toString().startsWith(capitalizedValor)){
          queryResultado.add(x);
        }
      }
      
    }
    else if(valor.length == 0){
      queryResultado = [];
      barraDePesquisa.value = false;
    }
  }
 
  @override
  void onInit() async{
    super.onInit();
    myGlobalController = Get.find();
   
  }
  
  init(context) async {
      dados = await searchApi('specialties');
      return dados;
  }

 
 }



class SelectSpecialtyPage extends StatelessWidget {
  SelectSpecialtyPage({Key? key}) : super(key: key);
  var selectSpecialtyPageController = Get.put(SelectSpecialtyPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<SelectSpecialtyPageController>(
        init: SelectSpecialtyPageController(),
        builder: (_) {
          return Scaffold( 
            body: FutureBuilder(
              future: selectSpecialtyPageController.init(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   if (snapshot.hasData) {
                    return Container(
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
                            MySearchTextFormField(controller: selectSpecialtyPageController.search,color: Color.fromARGB(255, 61, 102, 159),onChanged: (){ selectSpecialtyPageController.buscaInicial(selectSpecialtyPageController.search.text);}),
                            SizedBox(height: 20,),
                            Text('Selecione uma especialidade',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                            SizedBox(height:5),
                            Expanded(
                                child:
                                Obx(
                                  () =>
                                  selectSpecialtyPageController.barraDePesquisa.value?
                                  ListView(
                                    children:
                                        selectSpecialtyPageController.buildWidgets(context,selectSpecialtyPageController.queryResultado),
                                  ):
                                  ListView(
                                    children:
                                        selectSpecialtyPageController.buildWidgets(context,selectSpecialtyPageController.dados),
                                  )
                                )
                              ),
                              SizedBox(height: 30,),
                              MyButton(label: 'Continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){selectSpecialtyPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                              SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    );
                   }else{
                 
                    return TryAgainPage();          
                   }
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar a lista${snapshot.error}');
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

