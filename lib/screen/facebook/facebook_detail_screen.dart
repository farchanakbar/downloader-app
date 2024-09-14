import 'package:app_downloader/bloc/facebook/facebook_bloc.dart';
import 'package:app_downloader/data/models/facebook.dart';
import 'package:app_downloader/helper/format_file_size.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacebookDetailScreen extends StatelessWidget {
  final FacebookReels facebookReels;

  const FacebookDetailScreen({
    required this.facebookReels,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FacebookBloc facebookBlocMp4 = FacebookBloc();
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      facebookReels.thumbnail.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              formatFile.note,
              style: TextStyle(color: Colors.red),
            ),

            //Download video Facebook
            BlocBuilder<FacebookBloc, FacebookState>(
              bloc: facebookBlocMp4,
              builder: (context, state) {
                String idIg = facebookReels.thumbnail.toString().length > 10
                    ? facebookReels.thumbnail.toString().substring(
                        facebookReels.thumbnail.toString().length - 10)
                    : facebookReels.thumbnail.toString();
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is FacebookDownloadInProgress
                          ? const Color.fromARGB(190, 250, 250, 250)
                          : Colors.blue),
                  onPressed: () {
                    state is FacebookDownloadInProgress
                        ? null
                        : facebookBlocMp4.add(
                            FacebookStartDownloadMp4(
                              facebookReels.url.toString(),
                              idIg,
                            ),
                          );
                  },
                  child: Text(
                    state is FacebookLoading ? 'Loading...' : 'Download Video',
                    style: TextStyle(
                        color: state is FacebookDownloadInProgress
                            ? const Color.fromARGB(255, 209, 199, 199)
                            : Colors.white),
                  ),
                );
              },
            ),
            BlocBuilder<FacebookBloc, FacebookState>(
              bloc: facebookBlocMp4,
              builder: (context, state) {
                if (state is FacebookDownloadInProgress) {
                  return Text(
                    '${formatFile.formatFileSize(state.progress)}/${formatFile.formatFileSize(state.total)}',
                    textAlign: TextAlign.center,
                  );
                } else if (state is FacebookCompleted) {
                  return const Center(
                    child: Text('Download Selesai'),
                  );
                } else if (state is FacebookError) {
                  return const Center(
                    child: Text('Download Dibatalkan'),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<FacebookBloc, FacebookState>(
              bloc: facebookBlocMp4,
              builder: (context, state) {
                if (state is FacebookDownloadInProgress) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      facebookBlocMp4.add(FacebookCancelDownloadMp4());
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
