import 'package:app_downloader/bloc/mediafire/mediafire_bloc.dart';
import 'package:app_downloader/data/constans/color.dart';
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
      backgroundColor: color1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ButtonBack(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          mediafire.filename.toString(),
                          style: TextStyle(
                            color: color3,
                          ),
                        ),
                        Text(
                          mediafire.filetype.toString(),
                          style: TextStyle(
                            color: color3,
                          ),
                        ),
                        Text(
                          mediafire.ext.toString(),
                          style: TextStyle(
                            color: color3,
                          ),
                        ),
                        Text(
                          mediafire.filesizeH.toString(),
                          style: TextStyle(
                            color: color3,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          formatFile.note,
                          style: const TextStyle(color: Colors.red),
                        ),

                        //Download file mediafire
                        BlocBuilder<MediafireBloc, MediafireState>(
                          bloc: mediafireBloc,
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        state is MediafireDownloadInProgress
                                            ? const Color.fromARGB(
                                                190, 250, 250, 250)
                                            : Colors.blue),
                                onPressed: () {
                                  state is MediafireDownloadInProgress
                                      ? null
                                      : mediafireBloc.add(
                                          MediafireStartDownload(
                                              mediafire.url.toString(),
                                              mediafire.filename.toString(),
                                              mediafire.ext
                                                  .toString()
                                                  .toLowerCase()),
                                        );
                                },
                                child: Text(
                                  state is MediafireLoading
                                      ? 'Loading...'
                                      : 'Download',
                                  style: TextStyle(
                                      color:
                                          state is MediafireDownloadInProgress
                                              ? const Color.fromARGB(
                                                  255, 209, 199, 199)
                                              : Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<MediafireBloc, MediafireState>(
                          bloc: mediafireBloc,
                          builder: (context, state) {
                            if (state is MediafireDownloadInProgress) {
                              return Text(
                                style: TextStyle(
                                  color: color3,
                                ),
                                '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(state.total)}',
                                textAlign: TextAlign.center,
                              );
                            } else if (state is MediafireCompleted) {
                              return Center(
                                child: Text(
                                  'Download Selesai',
                                  style: TextStyle(
                                    color: color3,
                                  ),
                                ),
                              );
                            } else if (state is MediafireError) {
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
                        BlocBuilder<MediafireBloc, MediafireState>(
                          bloc: mediafireBloc,
                          builder: (context, state) {
                            if (state is MediafireDownloadInProgress) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    mediafireBloc
                                        .add(MediafireCancelDownload());
                                  },
                                  child: const Text('Batal Download'),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
