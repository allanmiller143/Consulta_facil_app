import 'package:flutter/material.dart';

class MySearchTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color color;
  final VoidCallback onChanged;
  final double width; // Novo parâmetro para a largura

  const MySearchTextFormField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.color = const Color.fromARGB(255, 141, 62, 62),
    required this.onChanged,
    this.width = double.infinity, // Valor padrão é double.infinity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: width, // Use o valor fornecido ou double.infinity por padrão
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: (value) => {
            onChanged(),
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            hintText: 'Pesquisar',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_outlined,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
