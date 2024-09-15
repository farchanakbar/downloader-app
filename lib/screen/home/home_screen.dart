import 'package:app_downloader/screen/chatgpt/chat_gpt_screen.dart';
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
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'AI',
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
                      builder: (context) => const ChatGptScreen(),
                    ),
                  ),
                  child: const Logo(
                    logo: 'assets/logo/gpt-logo.png',
                    title: 'Chat GPT',
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GdriveScreen()),
                  ),
                  child: const Logo(
                    logo: 'assets/logo/remini-logo.png',
                    title: 'Remini',
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
                    logo: 'assets/logo/remove-logo.png',
                    title: 'Remove BG',
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
        Text(title)
      ],
    );
  }
}
