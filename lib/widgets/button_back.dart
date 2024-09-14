import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Row(
        children: [Icon(Icons.arrow_back_ios_new_rounded), Text('Kembali')],
      ),
    );
  }
}
