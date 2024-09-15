import 'dart:io';

import 'package:app_downloader/data/api_service.dart';
import 'package:app_downloader/data/models/mediafire.dart';
import 'package:app_downloader/helper/save_delete_video.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'mediafire_event.dart';
part 'mediafire_state.dart';

class MediafireBloc extends Bloc<MediafireEvent, MediafireState> {
  final dio = ApiService().dio;
  CancelToken cancelToken = ApiService().cancelToken;

  MediafireBloc() : super(MediafireInitial()) {
    on<FetchMediafire>(
      (event, emit) async {
        emit(MediafireLoading());
        try {
          final response =
              await dio.get('/api/downloader/mediafire?url=${event.url}');
          emit(
            MediafireLoaded(Mediafire.fromJson(response.data)),
          );
          emit(MediafireCompleted());
        } catch (e) {
          emit(
            const MediafireError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<MediafireStartDownload>((event, emit) async {
      emit(MediafireLoading());
      final dir = Directory("/storage/emulated/0/Download/");
      String fileName = 'FarchanMediafire-${event.fileName}';
      String path = '${dir.path}$fileName';
      if (event.tipeFile == 'mp4') {
        // print(event.tipeFile);
        try {
          await dio.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(MediafireDownloadInProgress(received, total));
              }
            },
            cancelToken: cancelToken,
          );
          await SaveDeleteVideo().saveDownloadedVideoToGallery(
            videoPath: path,
            id: fileName,
          );
          await SaveDeleteVideo().removeDownloadedVideo(videoPath: path);
          emit(MediafireCompleted());
        } catch (e) {
          emit(MediafireError(e.toString()));
        }
      } else {
        try {
          await dio.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(MediafireDownloadInProgress(received, total));
              }
            },
            cancelToken: cancelToken,
          );
          emit(MediafireCompleted());
        } catch (e) {
          emit(
            MediafireError(
              e.toString(),
            ),
          );
        }
      }
    });

    on<MediafireCancelDownload>(
      (event, emit) {
        cancelToken.cancel();
        cancelToken = CancelToken();
        emit(const MediafireError('Download File Dibatalkan'));
      },
    );

    on<MediafireTextChanged>(
      (event, emit) {
        emit(
          MediafireText(event.isText),
        );
      },
    );
  }
}
