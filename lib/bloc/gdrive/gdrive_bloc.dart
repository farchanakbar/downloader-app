import 'dart:io';

import 'package:app_downloader/data/api_service.dart';
import 'package:app_downloader/data/models/google_drive.dart';
import 'package:app_downloader/helper/save_delete_video.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'gdrive_event.dart';
part 'gdrive_state.dart';

class GdriveBloc extends Bloc<GdriveEvent, GdriveState> {
  final dio = ApiService().dio;
  CancelToken cancelToken = ApiService().cancelToken;

  GdriveBloc() : super(GdriveInitial()) {
    on<FetchGdrive>(
      (event, emit) async {
        emit(GdriveLoading());
        try {
          final response =
              await dio.get('/api/downloader/gdrive?url=${event.url}');
          if (response.data['error'] == true) {
            emit(GdriveError('Link Bermasalah, Pastikan tidak private'));
          } else {
            emit(
              GdriveLoaded(GoogleDrive.fromJson(response.data)),
            );
            emit(GdriveCompleted());
          }
        } catch (e) {
          emit(
            const GdriveError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<GdriveStartDownload>((event, emit) async {
      final dir = Directory("/storage/emulated/0/Download/");
      String titleFile = 'FarchanGdrive-${event.fileName}';
      String path = '${dir.path}$titleFile';
      List tipeFile = event.tipeFile.split('/');
      print(tipeFile[1]);
      print(path);
      emit(GdriveLoading());
      if (tipeFile[1] == 'mp4' ||
          tipeFile[1] == 'jpeg' ||
          tipeFile[1] == 'png') {
        try {
          await dio.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(GdriveDownloadInProgress(received, total));
              }
            },
            cancelToken: cancelToken,
          );
          await SaveDeleteVideo().saveDownloadedVideoToGallery(
            videoPath: path,
            id: titleFile,
          );
          await SaveDeleteVideo().removeDownloadedVideo(videoPath: path);
          emit(GdriveCompleted());
        } catch (e) {
          emit(GdriveError(e.toString()));
        }
      } else {
        try {
          await dio.download(
            event.url,
            path,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                emit(GdriveDownloadInProgress(received, total));
              }
            },
            cancelToken: cancelToken,
          );
          emit(GdriveCompleted());
        } catch (e) {
          emit(
            GdriveError(
              e.toString(),
            ),
          );
        }
      }
    });

    on<GdriveCancelDownload>(
      (event, emit) {
        cancelToken.cancel();
        cancelToken = CancelToken();
        emit(const GdriveError('Download File Dibatalkan'));
      },
    );

    on<GdriveTextChanged>(
      (event, emit) {
        emit(
          GdriveText(event.isText),
        );
      },
    );
  }
}
