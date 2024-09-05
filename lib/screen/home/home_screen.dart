import 'package:app_downloader/screen/tiktok/tiktok_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Mau Download Apa?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TiktokScreen(),
                    ),
                  ),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/logo/tiktok-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //
                  },
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/logo/instagram-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //
                  },
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/logo/gdrive-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
