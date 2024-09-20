import 'package:app_downloader/data/constans/color.dart';
import 'package:app_downloader/screen/facebook/facebook_screen.dart';
import 'package:app_downloader/screen/gdrive/gdrive_screen.dart';
import 'package:app_downloader/screen/instagram/instagram_screen.dart';
import 'package:app_downloader/screen/mediafire/mediafire_screen.dart';
import 'package:app_downloader/screen/tiktok/tiktok_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'DOWNLOADER APP',
                      style: TextStyle(
                        fontSize: 20,
                        color: color3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TiktokScreen(),
                          ),
                        ),
                        child: const Logo(
                          logo: 'assets/logo/tiktok-logo.png',
                          title: 'Tiktok',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InstagramScreen(),
                          ),
                        ),
                        child: const Logo(
                          logo: 'assets/logo/instagram-logo.png',
                          title: 'Instagram',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FacebookScreen(),
                          ),
                        ),
                        child: const Logo(
                          logo: 'assets/logo/facebook-logo.png',
                          title: 'Facebook',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MediafireScreen(),
                          ),
                        ),
                        child: const Logo(
                          logo: 'assets/logo/mediafire-logo.png',
                          title: 'Mediafire',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GdriveScreen()),
                        ),
                        child: const Logo(
                          logo: 'assets/logo/gdrive-logo.png',
                          title: 'Google Drive',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'create by farchan akbar',
                style: TextStyle(
                  color: color3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final String logo;
  final String title;
  const Logo({
    required this.logo,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(
            logo,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: color3,
          ),
        )
      ],
    );
  }
}
