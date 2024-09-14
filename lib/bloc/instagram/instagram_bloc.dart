import 'package:app_downloader/data/models/instagram.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

import '../../helper/save_delete_video.dart';

part 'instagram_event.dart';
part 'instagram_state.dart';

class InstagramBloc extends Bloc<InstagramEvent, InstagramState> {
  final dioMp4 = Dio(
    BaseOptions(
      baseUrl: 'https://api.ryzendesu.vip',
      headers: {
        'User-Agent': 'axios',
      },
    ),
  );

  CancelToken cancelTokenMp4 = CancelToken();

  InstagramBloc() : super(InstagramInitial()) {
    on<FetchInstagram>(
      (event, emit) async {
        emit(InstagramLoading());
        try {
          final response =
              await dioMp4.get('/api/downloader/igdl?url=${event.url}');
          var data = response.data['data'][0];
          var hasil = Instagram.fromJson(data);
          emit(
            InstagramLoaded(hasil),
          );
          emit(InstagramCompleted());
        } catch (e) {
          emit(
            const InstagramError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<InstagramStartDownloadMp4>((event, emit) async {
      emit(InstagramLoading());
      final dir = await getApplicationDocumentsDirectory();
      String fileName = 'FarchanInstagram-${event.fileName}.mp4';
      String path = '${dir.path}/$fileName';
      print(path);
      try {
        await dioMp4.download(
          event.url,
          path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              emit(InstagramDownloadInProgress(received, total));
            }
          },
          cancelToken: cancelTokenMp4,
        );
        await SaveDeleteVideo()
            .saveDownloadedVideoToGallery(videoPath: path, id: fileName);
        await SaveDeleteVideo().removeDownloadedVideo(videoPath: path);
        emit(InstagramCompleted());
      } catch (e) {
        emit(InstagramError(e.toString()));
      }
    });

    on<InstagramCancelDownloadMp4>(
      (event, emit) {
        cancelTokenMp4.cancel();
        cancelTokenMp4 = CancelToken();
        emit(const InstagramError('Download Mp4 Dibatalkan'));
      },
    );

    on<InstagramTextChanged>(
      (event, emit) {
        emit(
          InstagramText(event.isText),
        );
      },
    );
  }
}
