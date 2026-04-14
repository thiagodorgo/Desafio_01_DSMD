import 'package:dio/dio.dart';

  class HttpClient {
    static Dio createDio() {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://viacep.com.br/ws',
          connectTimeout: const Duration(seconds: 10).inMilliseconds,
          receiveTimeout: const Duration(seconds: 10).inMilliseconds,
          responseType: ResponseType.json,
        ),
      );

      dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: true,
          error: true,
        ),
      );

      return dio;
    }
  }
  