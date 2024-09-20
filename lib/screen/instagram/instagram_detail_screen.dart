import 'package:app_downloader/bloc/instagram/instagram_bloc.dart';
import 'package:app_downloader/data/constans/color.dart';
import 'package:app_downloader/data/models/instagram.dart';
import 'package:app_downloader/helper/format_file_size.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstagramDetailScreen extends StatelessWidget {
  final Instagram instagram;

  const InstagramDetailScreen({
    required this.instagram,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    InstagramBloc instagramBlocMp4 = InstagramBloc();
    FormatFileSize formatFile = FormatFileSize();

    return Scaffold(
      backgroundColor: color1,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const ButtonBack(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: color3,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  height: 400,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      instagram.thumbnail.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            instagram.title == null
                ? const SizedBox()
                : Text(
                    style: TextStyle(
                      color: color3,
                    ),
                    instagram.title.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
            const SizedBox(
              height: 20,
            ),
            Text(
              formatFile.note,
              style: const TextStyle(color: Colors.red),
            ),

            //Download video instagram
            BlocBuilder<InstagramBloc, InstagramState>(
              bloc: instagramBlocMp4,
              builder: (context, state) {
                String idIg = instagram.thumbnail.toString().length > 10
                    ? instagram.thumbnail
                        .toString()
                        .substring(instagram.thumbnail.toString().length - 10)
                    : instagram.thumbnail.toString();
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is InstagramDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is InstagramDownloadInProgress
                        ? null
                        : instagramBlocMp4.add(
                            InstagramStartDownloadMp4(
                              instagram.url.toString(),
                              idIg,
                            ),
                          );
                  },
                  child: Text(
                    state is InstagramLoading ? 'Loading...' : 'Download Video',
                    style: TextStyle(
                        color: state is InstagramDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<InstagramBloc, InstagramState>(
              bloc: instagramBlocMp4,
              builder: (context, state) {
                if (state is InstagramDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(state.total)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color3,
                    ),
                  );
                } else if (state is InstagramCompleted) {
                  return Center(
                    child: Text(
                      'Download Selesai',
                      style: TextStyle(
                        color: color3,
                      ),
                    ),
                  );
                } else if (state is InstagramError) {
                  return Center(
                    child: Text(
                      'Download Dibatalkan',
                      style: TextStyle(
                        color: color3,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<InstagramBloc, InstagramState>(
              bloc: instagramBlocMp4,
              builder: (context, state) {
                if (state is InstagramDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      instagramBlocMp4.add(InstagramCancelDownloadMp4());
                    },
                    child: const Text(
                      'Batal Download',
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
