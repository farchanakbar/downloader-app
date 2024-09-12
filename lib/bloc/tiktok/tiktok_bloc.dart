import 'dart:io';

import 'package:app_downloader/data/models/tiktok.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final dioMp4 = Dio(
    BaseOptions(
      baseUrl: 'https://api.ryzendesu.vip',
      headers: {
        'User-Agent': 'axios',
      },
    ),
  );

  final dioMp3 = Dio(
    BaseOptions(
      baseUrl: 'https://api.ryzendesu.vip',
      headers: {
        'User-Agent': 'axios',
      },
    ),
  );

  CancelToken cancelTokenMp4 = CancelToken();
  CancelToken cancelTokenMp3 = CancelToken();

  Future<void> saveDownloadedVideoToGallery(
      {required String videoPath, required String id}) async {
    await ImageGallerySaver.saveFile(
      videoPath,
      name: 'FarchanIg-${id}',
    );
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
    } catch (error) {
      print('$error');
    }
  }

  TiktokBloc() : super(TiktokInitial()) {
    on<FetchTiktok>(
      (event, emit) async {
        String getLink = event.url;
        List link = getLink.split(' ');
        emit(TiktokLoading());
        try {
          final response =
              await dioMp4.get('/api/downloader/ttdl?url=${link[0]}');
          emit(
            TiktokLoaded(
              Tiktok.fromJson(
                response.data['data'],
              ),
            ),
          );
        } catch (e) {
          emit(
            const TiktokError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<StartDownloadMp4>(
      (event, emit) async {
        emit(TiktokLoading());
        final dir = await getApplicationDocumentsDirectory();
        String path = '${dir.path}/FarchanTiktok-${event.fileName}.mp4';
        print(path);
        try {
          await dioMp4.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(DownloadInProgress(received));
              }
            },
            cancelToken: cancelTokenMp4,
          );
          await saveDownloadedVideoToGallery(
              videoPath: path, id: event.fileName);
          await removeDownloadedVideo(videoPath: path);
          emit(TiktokCompleted());
        } catch (e) {
          emit(TiktokError(e.toString()));
        }
      },
    );

    on<StartDownloadMp3>(
      (event, emit) async {
        emit(TiktokLoading());
        final dir = Directory("/storage/emulated/0/Download/");
        String path = '${dir.path}/FarchanTiktok-${event.fileName}.mp3';
        try {
          await dioMp3.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(DownloadInProgress(received));
              }
            },
            cancelToken: cancelTokenMp3,
          );
          emit(TiktokCompleted());
        } catch (e) {
          emit(TiktokError(e.toString()));
        }
      },
    );

    on<CancelDownloadMp4>(
      (event, emit) {
        cancelTokenMp4.cancel();
        cancelTokenMp4 = CancelToken();
        emit(TiktokError('Download Mp4 Dibatalkan'));
      },
    );

    on<CancelDownloadMp3>(
      (event, emit) {
        cancelTokenMp3.cancel();
        cancelTokenMp3 = CancelToken();
        emit(TiktokError('Download Mp3 Dibatalkan'));
      },
    );

    on<TextChanged>(
      (event, emit) {
        print('${event.isText} test');
        emit(
          TiktokText(event.isText),
        );
      },
    );
  }
}
