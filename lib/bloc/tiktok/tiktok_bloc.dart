import 'dart:io';

import 'package:app_downloader/data/models/tiktok.dart';
import 'package:app_downloader/helper/save_delete_video.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
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
          emit(TiktokCompleted());
        } catch (e) {
          emit(
            const TiktokError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<TiktokStartDownloadMp4>(
      (event, emit) async {
        emit(TiktokLoading());
        final dir = await getApplicationDocumentsDirectory();
        String fileName = 'FarchanTiktok-${event.fileName}.mp4';
        String path = '${dir.path}/$fileName';
        print(path);
        try {
          await dioMp4.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(TiktokDownloadInProgress(received));
              }
            },
            cancelToken: cancelTokenMp4,
          );
          await SaveDeleteVideo()
              .saveDownloadedVideoToGallery(videoPath: path, id: fileName);
          await SaveDeleteVideo().removeDownloadedVideo(videoPath: path);
          emit(TiktokCompleted());
        } catch (e) {
          emit(TiktokError(e.toString()));
        }
      },
    );

    on<TiktokStartDownloadMp3>(
      (event, emit) async {
        emit(TiktokLoading());
        final dir = Directory("/storage/emulated/0/Download/");
        String fileName = 'FarchanTiktok-${event.fileName}.mp3';
        String path = '${dir.path}$fileName';
        try {
          await dioMp3.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(TiktokDownloadInProgress(received));
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

    on<TiktokCancelDownloadMp4>(
      (event, emit) {
        cancelTokenMp4.cancel();
        cancelTokenMp4 = CancelToken();
        emit(const TiktokError('Download Mp4 Dibatalkan'));
      },
    );

    on<TiktokCancelDownloadMp3>(
      (event, emit) {
        cancelTokenMp3.cancel();
        cancelTokenMp3 = CancelToken();
        emit(const TiktokError('Download Mp3 Dibatalkan'));
      },
    );

    on<TiktokTextChanged>(
      (event, emit) {
        emit(
          TiktokText(event.isText),
        );
      },
    );
  }
}
