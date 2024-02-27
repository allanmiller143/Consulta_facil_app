import 'package:flutter/material.dart';

class MySearchTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final bool obscureText;
 

  const MySearchTextFormField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.4,
                color: Colors.black45,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              obscureText: obscureText,
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              decoration:  const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search_outlined,)
            ),
          )
                ),
        );
  }
}
