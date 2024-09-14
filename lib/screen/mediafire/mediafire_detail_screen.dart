import 'package:app_downloader/bloc/mediafire/mediafire_bloc.dart';
import 'package:app_downloader/data/models/mediafire.dart';
import 'package:app_downloader/helper/format_file_size.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediafireDetailScreen extends StatelessWidget {
  final Mediafire mediafire;

  const MediafireDetailScreen({
    required this.mediafire,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MediafireBloc mediafireBloc = MediafireBloc();
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
            Column(
              children: [
                Text(mediafire.filename.toString()),
                Text(mediafire.filetype.toString()),
                Text(mediafire.ext.toString()),
                Text(mediafire.filesizeH.toString()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatFile.note,
              style: TextStyle(color: Colors.red),
            ),

            //Download file mediafire
            BlocBuilder<MediafireBloc, MediafireState>(
              bloc: mediafireBloc,
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is MediafireDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is MediafireDownloadInProgress
                        ? null
                        : mediafireBloc.add(
                            MediafireStartDownload(
                                mediafire.url.toString(),
                                mediafire.filename.toString(),
                                mediafire.ext.toString().toLowerCase()),
                          );
                  },
                  child: Text(
                    state is MediafireLoading ? 'Loading...' : 'Download',
                    style: TextStyle(
                        color: state is MediafireDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<MediafireBloc, MediafireState>(
              bloc: mediafireBloc,
              builder: (context, state) {
                if (state is MediafireDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(state.total)}',
                    textAlign: TextAlign.center,
                  );
                } else if (state is MediafireCompleted) {
                  return const Center(
                    child: Text('Download Selesai'),
                  );
                } else if (state is MediafireError) {
                  return const Center(
                    child: Text('Download Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<MediafireBloc, MediafireState>(
              bloc: mediafireBloc,
              builder: (context, state) {
                if (state is MediafireDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      mediafireBloc.add(MediafireCancelDownload());
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
