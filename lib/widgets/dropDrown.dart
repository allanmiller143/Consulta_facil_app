import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomDropdownButton extends StatelessWidget {
  final Map<String, dynamic> items;
  final RxString controller;
  final String label;
  final double width; // Adicionado o parâmetro para a largura


  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.controller,
    required this.label,
    this.width = double.infinity, // Valor padrão para a largura
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14)),
          Container(
            width: width, // Use a largura padrão ou a largura passada como parâmetro
            padding: const EdgeInsets.only(right: 15),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
              value: controller.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.value = newValue;
                }
              },
              elevation: 8,
              menuMaxHeight: 200,
              underline: Container(
                color: Colors.transparent,
              ),
              items: items.entries.map((MapEntry<String, dynamic> entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      entry.value.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'AsapCondensed-Bold',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
