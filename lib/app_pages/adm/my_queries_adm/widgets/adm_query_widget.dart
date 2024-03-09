import 'package:app_clinica/widgets/alert.dart';
import 'package:app_clinica/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdmQueryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const AdmQueryCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleTextStyle = const TextStyle(fontSize: 14,color: Color.fromARGB(255, 245, 245, 245),fontWeight: FontWeight.w500);
    TextStyle listTileTextStyle = const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold);
    TextStyle listTileSubtitleTextStyle = const TextStyle(fontSize: 12, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w200);

    String data = "${DateFormat('dd/MM/yyyy HH:mm').format(item['Date'])}";
    return ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${item['Query_id']}',style: listTileTextStyle,),
                  Text(data,style: listTileSubtitleTextStyle,),
                ]),
              subtitle: Text('${item['UserName']} - Clique para ver mais detalhes',style: listTileSubtitleTextStyle,),
              iconColor: const Color.fromARGB(255, 255, 255, 255),
              collapsedIconColor: const Color.fromARGB(255, 255, 255, 255),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item['Status'] == 'Concluída' ? Text('Status: ${item['Status']}',style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 65, 201, 65)),) :  Text('Status: ${item['Status']}',style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),                   
                      Text('Consulta marcada em 22 de Abril de Janeiro',style: listTileSubtitleTextStyle,), 
                      Row(
                        children: [
                          Text('${item['Specialty']}: ',style: titleTextStyle,),
                          Text(' ${item['Specialist']}',style: listTileSubtitleTextStyle,),
                        ],
                      ),  
                      const SizedBox(height: 5,),
                      item['Status'] == 'Concluída' ? const SizedBox(height: 0,) :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              showConfirmationDialog(context, 'Alerta', 'Em desenvolvimento...');
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color.fromARGB(255, 234, 39, 9)
                              ),
                              child: Text('Cancelar consulta',style: titleTextStyle,)
                            ),
                          ),
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: (){
                              showConfirmationDialog(context, 'Alerta', 'Em desenvolvimento...');
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.amber
                              ),
                              child: Text('Alterar consulta',style: titleTextStyle,)
                            ),
                          ),
                        ],
                      ),
                      

                      
                    ]
                  ),
                )
                
              ],
            );
  }
}