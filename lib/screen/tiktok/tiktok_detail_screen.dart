import 'package:app_downloader/data/models/tiktok.dart';
import 'package:app_downloader/helper/format_file_size.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tiktok/tiktok_bloc.dart';

class TiktokDetailScreen extends StatelessWidget {
  final Tiktok tiktok;

  const TiktokDetailScreen({
    required this.tiktok,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TiktokBloc tiktokBlocMp4 = TiktokBloc();
    TiktokBloc tiktokBlocMp4Hd = TiktokBloc();
    TiktokBloc tiktokBlocMp3 = TiktokBloc();
    FormatFileSize formatFile = FormatFileSize();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ButtonBack(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      tiktok.cover.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              tiktok.title.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              tiktok.author!.nickname.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${tiktok.duration} Detik'),
                Container(
                  height: 10,
                  width: 1,
                  color: Colors.black,
                ),
                Text(formatFile.formatFileSize(tiktok.size!)),
                Container(
                  height: 10,
                  width: 1,
                  color: Colors.black,
                ),
                tiktok.hdSize == 0
                    ? const Text('-')
                    : Text('HD ${formatFile.formatFileSize(tiktok.hdSize!)}'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatFile.note,
              style: TextStyle(color: Colors.red),
            ),

            //Download video tiktok biasa
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4,
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is TiktokDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is TiktokDownloadInProgress
                        ? null
                        : tiktokBlocMp4.add(
                            TiktokStartDownloadMp4(
                              tiktok.play.toString(),
                              tiktok.id.toString(),
                            ),
                          );
                  },
                  child: Text(
                    state is TiktokLoading ? 'Loading...' : 'Download Video',
                    style: TextStyle(
                        color: state is TiktokDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(tiktok.size!)}',
                    textAlign: TextAlign.center,
                  );
                } else if (state is TiktokCompleted) {
                  return const Center(
                    child: Text('Download Selesai'),
                  );
                } else if (state is TiktokError) {
                  return const Center(
                    child: Text('Download Mp4 Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      tiktokBlocMp4.add(TiktokCancelDownloadMp4());
                    },
                    child: const Text('Batal Download'),
                  );
                }
                return const SizedBox();
              },
            ),

            //Download video tiktok HD
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4Hd,
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is TiktokDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is TiktokDownloadInProgress
                        ? null
                        : tiktokBlocMp4Hd.add(
                            TiktokStartDownloadMp4(
                              tiktok.hdplay.toString(),
                              '${tiktok.id}HD',
                            ),
                          );
                  },
                  child: Text(
                    state is TiktokLoading ? 'Loading...' : 'Download Video HD',
                    style: TextStyle(
                        color: state is TiktokDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4Hd,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(tiktok.hdSize!)}',
                    textAlign: TextAlign.center,
                  );
                } else if (state is TiktokCompleted) {
                  return const Center(
                    child: Text('Download Selesai'),
                  );
                } else if (state is TiktokError) {
                  return const Center(
                    child: Text('Download Mp4 HD Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp4Hd,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      tiktokBlocMp4Hd.add(TiktokCancelDownloadMp4());
                    },
                    child: const Text('Batal Download'),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.music_note_sharp,
                  size: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    tiktok.musicInfo!.title.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            //Download musik mp3
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp3,
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is TiktokDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is TiktokDownloadInProgress
                        ? null
                        : tiktokBlocMp3.add(
                            TiktokStartDownloadMp3(
                              tiktok.music.toString(),
                              tiktok.musicInfo!.id.toString(),
                            ),
                          );
                  },
                  child: Text(
                    state is TiktokLoading ? 'Loading...' : 'Download Musik',
                    style: TextStyle(
                        color: state is TiktokDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp3,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return Text(
                    formatFile.formatFileSize(state.progress),
                    textAlign: TextAlign.center,
                  );
                } else if (state is TiktokCompleted) {
                  return const Center(
                    child: Text('Download Mp3 Selesai'),
                  );
                } else if (state is TiktokError) {
                  return const Center(
                    child: Text('Download Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<TiktokBloc, TiktokState>(
              bloc: tiktokBlocMp3,
              builder: (context, state) {
                if (state is TiktokDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      tiktokBlocMp3.add(TiktokCancelDownloadMp3());
                    },
                    child: const Text('Batal Download'),
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
