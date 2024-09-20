import 'package:flutter/material.dart';

import '../data/constans/color.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            color: color3,
          ),
          Text(
            'Kembali',
            style: TextStyle(
              color: color3,
            ),
          )
        ],
      ),
    );
  }
}
