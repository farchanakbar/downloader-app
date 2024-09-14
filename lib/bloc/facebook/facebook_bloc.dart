import 'package:app_downloader/data/models/facebook.dart';
import 'package:app_downloader/helper/save_delete_video.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'facebook_event.dart';
part 'facebook_state.dart';

class FacebookBloc extends Bloc<FacebookEvent, FacebookState> {
  final dioMp4 = Dio(
    BaseOptions(
      baseUrl: 'https://api.ryzendesu.vip',
      headers: {
        'User-Agent': 'axios',
      },
    ),
  );

  CancelToken cancelTokenMp4 = CancelToken();
  FacebookBloc() : super(FacebookInitial()) {
    on<FetchFacebook>(
      (event, emit) async {
        emit(FacebookLoading());
        try {
          final response =
              await dioMp4.get('/api/downloader/fbdl?url=${event.url}');
          var data = response.data['data'][0];
          var hasil = FacebookReels.fromJson(data);
          emit(
            FacebookLoaded(hasil),
          );
          emit(FacebookCompleted());
        } catch (e) {
          emit(
            const FacebookError(
              'Link tidak ditemukan, silahkan cek kembali!',
            ),
          );
        }
      },
    );

    on<FacebookStartDownloadMp4>((event, emit) async {
      emit(FacebookLoading());
      final dir = await getApplicationCacheDirectory();
      String fileName = 'FarchanFacebook-${event.fileName}.mp4';
      String path = '${dir.path}/$fileName';
      print(path);
      try {
        await dioMp4.download(
          event.url,
          path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              emit(FacebookDownloadInProgress(received, total));
            }
          },
          cancelToken: cancelTokenMp4,
        );
        await SaveDeleteVideo()
            .saveDownloadedVideoToGallery(videoPath: path, id: fileName);
        await SaveDeleteVideo().removeDownloadedVideo(videoPath: path);
        emit(FacebookCompleted());
      } catch (e) {
        emit(FacebookError(e.toString()));
      }
    });

    on<FacebookCancelDownloadMp4>(
      (event, emit) {
        cancelTokenMp4.cancel();
        cancelTokenMp4 = CancelToken();
        emit(const FacebookError('Download Mp4 Dibatalkan'));
      },
    );

    on<FacebookTextChanged>(
      (event, emit) {
        emit(
          FacebookText(event.isText),
        );
      },
    );
  }
}
