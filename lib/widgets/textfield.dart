import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? icon;

  const MyTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.icon,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.4,
              color: Colors.black45,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color:const  Color.fromARGB(255, 15, 39, 108)
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
