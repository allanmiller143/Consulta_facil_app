// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/header.dart';
import 'package:app_clinica/widgets/queryCard.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QueriesPageController extends GetxController {

  RxBool barraDePesquisa = false.obs;
  var queryResultado = [];
  var tempSearchStore = [];
  final List<Map<String, dynamic>> dados = [
    {
      'title': 'Cardiologista',
      'imageAsset': 'assets/imgs/cardiologista.png',
      'content': 'O cardiologista é um médico especializado em cuidar do sistema cardiovascular, tratando condições como doenças cardíacas, hipertensão e insuficiência cardíaca.',
      'search' : 'c'
    },
    {
      'title': 'Dermatologista',
      'imageAsset': 'assets/imgs/dermatologista.png',
      'content': 'O dermatologista é um especialista em doenças da pele, cabelo e unhas, podendo tratar condições como acne, eczema, psoríase e câncer de pele.',
      'search' : 'D'
    },
    {
      'title': 'Ortopedista',
      'imageAsset': 'assets/imgs/ortopedista.png',
      'content': 'O ortopedista é um médico que se dedica ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
      'search' : 'o'
    },
    {
      'title': 'Oftalmologista',
      'imageAsset': 'assets/imgs/oftamologista.png',
      'content': 'O oftalmologista é responsável pelo diagnóstico e tratamento de condições oculares, como miopia, astigmatismo, catarata e glaucoma.',
      'search' : 'o'
    },
    {
      'title': 'Ginecologista',
      'imageAsset': 'assets/imgs/ginecologista.png',
      'content': 'O ginecologista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
      'search' : 'g'
    },
    {
      'title': 'Dentista',
      'imageAsset': 'assets/imgs/dentista.png',
      'content': 'O dentista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
      'search' : 'd'
    },
    // Adicione mais especialidades conforme necessário
  ].obs;
    

  List<Widget> buildWidgets(context,list) {
    List<Widget> cards = [];
  
      for (int i = 0; i < list.length; i ++) {
        cards.add(
          MyQueryButton(
            selected: selected,
            info: list[i],
            onPressed: () {
              selected.value = list[i]['title'];
            },
            image: list[i]['imageAsset'],
      
          )
        );
      }

    return cards;
  }

  var search = TextEditingController();
  RxString selected = ''.obs;


    void toNextScreen(context){
      if(selected.value == ''){
        showConfirmationDialog(context, 'Alerta', 'Por favor, selecione uma especialidade para proceguir para a proxima etapa! ');
      }
      else{
        Get.toNamed('/doctor');
      }
    }

      buscaInicial(valor) {
        print('chamei');
        if (valor.length != 0 && queryResultado.isEmpty) {
          var capitalizedValor = valor[0].toUpperCase() + valor.substring(1);
          barraDePesquisa.value = true;
          for(var x in dados){
            if(x['title'].toString().startsWith(capitalizedValor)){
              queryResultado.add(x);
            }
          }
          
        }
        else if(valor.length == 0){
          queryResultado = [];
          barraDePesquisa.value = false;
        }
        print(queryResultado);
        }
 }

class QueriesPage extends StatelessWidget {
  QueriesPage({Key? key}) : super(key: key);
  var queriesPageController = Get.put(QueriesPageController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<QueriesPageController>(
        init: QueriesPageController(),
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                      children: [  
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25,0,25,0),
                          child: Column(
                            children: [
                              MyHeader(),
                              SizedBox(height: 20,),
                              Text('Selecione uma especialidade',style: TextStyle( fontFamily: 'Nunito-VariableFont_wght', color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,fontWeight: FontWeight.w600 ),),
                              SizedBox(height:5),
                          
                            ],
                          ),
                        ),
                        
                        Expanded(
                          child:

                              ListView(
                                children:
                                    queriesPageController.buildWidgets(context,queriesPageController.dados),                                                                                      
                              )
                            ),
                          
                   
                          MyButton(label: 'continuar', borderRadius: BorderRadius.circular(50),  onPressed: (){queriesPageController.toNextScreen(context);},color: const Color.fromARGB(255, 255, 255, 255),fontColor:Color.fromARGB(255, 61, 102, 159)),
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
