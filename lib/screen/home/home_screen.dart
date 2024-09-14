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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(
              child: Text(
                'Downloader',
                style: TextStyle(
                  fontSize: 20,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/logo/tiktok-logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text('Tiktok')
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstagramScreen(),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/logo/instagram-logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text('Instagram')
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FacebookScreen(),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/logo/facebook-logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text('Facebook')
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/logo/mediafire-logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text('MediaFire')
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GdriveScreen()),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/logo/gdrive-logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text('Google Drive')
                    ],
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
