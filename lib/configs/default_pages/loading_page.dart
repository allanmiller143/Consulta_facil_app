import 'package:flutter/material.dart';

class LoadingWidget  extends StatelessWidget {

  const LoadingWidget(
    {super.key,}
  );

  @override
  Widget build(BuildContext context) {
    return  
    Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
            gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 15, 39, 108),
              Color.fromARGB(255, 6, 18, 42),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      child: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
    );
  }
}