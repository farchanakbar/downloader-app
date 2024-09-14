import 'package:flutter/material.dart';

class LogoApps extends StatelessWidget {
  final String img;

  const LogoApps({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.asset(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
