import 'package:app_downloader/data/models/tiktok.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final dio = Dio();
  TiktokBloc() : super(TiktokInitial()) {
    dio.options.baseUrl = 'https://api.ryzendesu.vip';
    dio.options.headers['User-Agent'] = 'axios';
    on<FetchTiktok>(
      (event, emit) async {
        String getLink = event.url;
        List link = getLink.split(' ');
        emit(TiktokLoading());
        try {
          final response = await dio.get('/api/downloader/ttdl?url=${link[0]}');
          emit(
            TiktokLoaded(
              Tiktok.fromJson(
                response.data['data'],
              ),
            ),
          );
        } catch (e) {
          emit(
            TiktokError(
              'Link salah, silahkan cek kembali!',
            ),
          );
        }
      },
    );
  }
}
