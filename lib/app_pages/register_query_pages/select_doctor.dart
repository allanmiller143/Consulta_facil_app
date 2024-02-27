// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:app_clinica/widgets/search_textfield.dart';
import 'package:app_clinica/widgets/specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectDoctorPageController extends GetxController {

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
                        MySearchTextFormField(controller: selectDoctorPageController.search),
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
                              selectDoctorPageController.buildWidgets(),
                        )
                      ),
                      SizedBox(height: 10,),
                      MyButton(label: 'Confirmar', onPressed: (){selectDoctorPageController.toNextScreen(context);}),
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
