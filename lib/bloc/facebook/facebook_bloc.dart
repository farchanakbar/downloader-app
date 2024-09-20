import 'package:app_downloader/data/api_service.dart';
import 'package:app_downloader/data/models/facebook.dart';
import 'package:app_downloader/helper/save_delete_video.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'facebook_event.dart';
part 'facebook_state.dart';

class FacebookBloc extends Bloc<FacebookEvent, FacebookState> {
  final dioMp4 = ApiService().dio;
  CancelToken cancelTokenMp4 = ApiService().cancelToken;
  FacebookBloc() : super(FacebookInitial()) {
    on<FetchFacebook>(
      (event, emit) async {
        emit(FacebookLoading());
        try {
          final response =
              await dioMp4.get('/api/downloader/fbdl?url=${event.url}');
          if (response.statusCode == 500) {
            // ignore: prefer_const_constructors
            emit(FacebookError('Server Gangguan'));
          } else {
            var data = response.data['data'][0];
            var hasil = FacebookReels.fromJson(data);
            emit(
              FacebookLoaded(hasil),
            );
            emit(FacebookCompleted());
          }
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
