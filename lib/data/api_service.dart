import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.ryzendesu.vip',
      headers: {
        'User-Agent': 'axios',
      },
    ),
  );

  CancelToken cancelToken = CancelToken();
}
