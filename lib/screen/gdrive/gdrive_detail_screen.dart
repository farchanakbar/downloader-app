import 'package:app_downloader/bloc/gdrive/gdrive_bloc.dart';
import 'package:app_downloader/data/models/google_drive.dart';
import 'package:app_downloader/helper/format_file_size.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GdriveDetailScreen extends StatelessWidget {
  final GoogleDrive gdrive;

  const GdriveDetailScreen({
    required this.gdrive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GdriveBloc gdriveB = GdriveBloc();
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
                Text(
                  gdrive.fileName.toString(),
                  textAlign: TextAlign.center,
                ),
                Text(gdrive.mimetype.toString()),
                Text(gdrive.fileSize.toString()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatFile.note,
              style: TextStyle(color: Colors.red),
            ),

            //Download file google drive
            BlocBuilder<GdriveBloc, GdriveState>(
              bloc: gdriveB,
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is GdriveDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is GdriveDownloadInProgress
                        ? null
                        : gdriveB.add(
                            GdriveStartDownload(
                                gdrive.downloadUrl.toString(),
                                gdrive.fileName.toString(),
                                gdrive.mimetype.toString().toLowerCase()),
                          );
                  },
                  child: Text(
                    state is GdriveLoading ? 'Loading...' : 'Download',
                    style: TextStyle(
                        color: state is GdriveDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<GdriveBloc, GdriveState>(
              bloc: gdriveB,
              builder: (context, state) {
                if (state is GdriveDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(state.total)}',
                    textAlign: TextAlign.center,
                  );
                } else if (state is GdriveCompleted) {
                  return const Center(
                    child: Text('Download Selesai'),
                  );
                } else if (state is GdriveError) {
                  return const Center(
                    child: Text('Download Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<GdriveBloc, GdriveState>(
              bloc: gdriveB,
              builder: (context, state) {
                if (state is GdriveDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      gdriveB.add(GdriveCancelDownload());
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
