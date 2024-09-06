import 'package:app_downloader/data/models/tiktok.dart';
import 'package:flutter/material.dart';

class TiktokDetailScreen extends StatelessWidget {
  final Tiktok tiktok;
  const TiktokDetailScreen({required this.tiktok, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_rounded),
                      Text('Kembali')
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      tiktok.aiDynamicCover!,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              tiktok.title!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: ClipOval(
                    child: Image.network(tiktok.author!.avatar!),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  tiktok.author!.nickname!,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
