// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectSpecialtyPageController extends GetxController {


   final List<Map<String, dynamic>> dados = [
    {
      'title': 'Cardiologista',
      'imageAsset': 'assets/imgs/agendar.png',
      'content': 'O cardiologista é um médico especializado em cuidar do sistema cardiovascular, tratando condições como doenças cardíacas, hipertensão e insuficiência cardíaca.',
    },
    {
      'title': 'Dermatologista',
      'imageAsset': 'assets/imgs/agendar.png',
      'content': 'O dermatologista é um especialista em doenças da pele, cabelo e unhas, podendo tratar condições como acne, eczema, psoríase e câncer de pele.',
    },
    {
      'title': 'Ortopedista',
      'imageAsset': 'assets/imgs/agendar.png',
      'content': 'O ortopedista é um médico que se dedica ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
    },
    {
      'title': 'Oftalmologista',
      'imageAsset': 'assets/imgs/agendar.png',
      'content': 'O oftalmologista é responsável pelo diagnóstico e tratamento de condições oculares, como miopia, astigmatismo, catarata e glaucoma.',
    },
    {
      'title': 'Ginecologista',
      'imageAsset': 'assets/imgs/agendar.png',
      'content': 'O ginecologista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
    },
    // Adicione mais especialidades conforme necessário
  ].obs;
    

    List<Widget> buildWidgets() {
      return dados.map((item) {
        return MySpecialtyCardButton(selected: selected,label: item['title'],onPressed: (){ selected.value = item['title'];},image: item['imageAsset'],info: item['content'],);
      }).toList();
    }
    var search = TextEditingController();
    RxString selected = ''.obs;


    void toNextScreen(context){
      if(selected.value == ''){
        showConfirmationDialog(context, 'Alerta', 'Por favor, selecione uma especialidade para proceguir para a proxima etap! ');
      }
      else{
        Get.toNamed('doctor');
      }
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
            backgroundColor: Color.fromARGB(222, 14, 114, 237),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 160),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(35),
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                    child: Column(
                      children: [
                        MySearchTextFormField(controller: selectSpecialtyPageController.search),
                        SizedBox(height:15),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Selecione uma especialidade',style: TextStyle(fontFamily: ' Nunito-VariableFont_wght',color: Color.fromARGB(222, 14, 114, 237),fontSize: 20,fontWeight: FontWeight.w900 ),),
                        ],
                      ),

                      Expanded(
                        child: 
                        ListView(
                          children:
                              selectSpecialtyPageController.buildWidgets(),
                        )
                      ),
                      SizedBox(height: 10,),
                      MyButton(label: 'Confirmar', onPressed: (){selectSpecialtyPageController.toNextScreen(context);}),
                      SizedBox(height: 10,),
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
