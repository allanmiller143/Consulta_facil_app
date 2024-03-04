// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_function_literals_in_foreach_calls
import 'package:app_clinica/configs/controllers/globalController.dart';
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
  RxBool barraDePesquisa = false.obs;

  var queryResultado = [];
  var tempSearchStore = [];


  final List<Map<String, dynamic>> dados = [
      {
        'title': 'Dr. João Silva',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. João Silva é um médico cardiologista com vasta experiência em cuidados cardíacos. Ele se especializou no tratamento de doenças cardíacas, hipertensão e insuficiência cardíaca.',
      },
      {
        'title': 'Dra. Maria Souza',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dra. Maria Souza é uma dermatologista renomada, especializada no tratamento de doenças da pele, cabelo e unhas. Sua experiência inclui o tratamento de acne, eczema, psoríase e câncer de pele.',
      },
      {
        'title': 'Dr. Roberto Santos',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. Roberto Santos é um ortopedista altamente qualificado, dedicado ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
      },
      {
        'title': 'Dra. Carla Lima',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dra. Carla Lima é uma oftalmologista experiente, especializada no diagnóstico e tratamento de condições oculares, incluindo miopia, astigmatismo, catarata e glaucoma.',
      },
      {
        'title': 'Dr. Marcos Oliveira',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. Marcos Oliveira é um ginecologista dedicado ao cuidado da saúde da mulher. Ele aborda questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
      },
      // Adicione mais médicos conforme necessário
    ].obs;

void addSearch() {
  for (int i = 0; i < dados.length; i++) {
    String title = dados[i]['title'];
    String prefix = title.contains('Dra. ') ? 'Dra. ' : 'Dr. ';
    int prefixIndex = prefix.length;

      String firstLetter = title[prefixIndex];
      
      // Criar um novo mapa temporário com o tipo correto
      Map<String, String> searchMap = {'Search': firstLetter};
      
      // Adicionar ao mapa original
      dados[i].addAll(searchMap);
  
  }
}


  List<Widget> buildWidgets(context,dados) {
    addSearch();
    List<Widget> rows = [];
      for (int i = 0; i < dados.length; i += 2) {
        List<Widget> rowChildren = [];
        rowChildren.add(
          MySpecialtyCardButton(
            selected: selected,
            label: dados[i]['title'],
            onPressed: () {
              selected.value = dados[i]['title'];
            },
            image: dados[i]['imageAsset'],
            info: dados[i]['content'],
          ),
        );

        // Adicione o segundo item da linha se existir
        if (i + 1 < dados.length) {
          rowChildren.add(
            MySpecialtyCardButton(
              selected: selected,
              label: dados[i + 1]['title'],
              onPressed: () {
                selected.value = dados[i + 1]['title'];
              },
              image: dados[i + 1]['imageAsset'],
              info: dados[i + 1]['content'],
            
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
      Get.toNamed('/date');
    }
  }
  
   buscaInicial(valor) {
        if (valor.length != 0 && queryResultado.isEmpty) {
          var capitalizedValor = valor[0].toUpperCase() + valor.substring(1);
          barraDePesquisa.value = true;
          for(var x in dados){
            if(x['Search'].toString().startsWith(capitalizedValor)){
              queryResultado.add(x);
            }
          }
          
        }
        else if(valor.length == 0){
          queryResultado = [];
          barraDePesquisa.value = false;
        }
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
            body: Container(
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
                        MySearchTextFormField(controller: selectDoctorPageController.search,color: Color.fromARGB(255, 61, 102, 159),onChanged: (){ selectDoctorPageController.buscaInicial(selectDoctorPageController.search.text);}),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            print(selectDoctorPageController.dados);
                          },
                          child: Text('Selecione um especilaista',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),)),
                        SizedBox(height:5),
                        
                        Expanded(
                            child: 
                            Obx(
                              ()=> selectDoctorPageController.barraDePesquisa.value?
                              
                              ListView(
                                children:
                                    selectDoctorPageController.buildWidgets(context,selectDoctorPageController.queryResultado),
                              ):
                              ListView(
                                children:
                                    selectDoctorPageController.buildWidgets(context,selectDoctorPageController.dados),
                              )
                            )
                          ),
                          SizedBox(height: 30,),
                          MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){selectDoctorPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
                          SizedBox(height: 30,),
                        
                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
