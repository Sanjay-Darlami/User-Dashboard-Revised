import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Duration defaultConnectionTimeOut = Duration(seconds: 120);
const Duration defaultReceiveTimeOut = Duration(seconds: 120);

Dio buildDio() {
  BaseOptions options = BaseOptions(
    connectTimeout: defaultConnectionTimeOut,
    receiveTimeout: defaultReceiveTimeOut,
  );

  final dio = Dio(options)
    ..interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers['Content-Type'] = "application/json";
          options.receiveDataWhenStatusError = true;
          return handler.next(options);
        }, onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        }, onError: (DioException e, ErrorInterceptorHandler handler) {
          if (e.response == null) {
            if (e.error is SocketException) {
              Map map = <String, dynamic>{'message': "No route to host"};
              return handler.next(DioException(
                requestOptions: e.requestOptions,
                error: map,
                message: (e.error as SocketException).message,
                type: DioExceptionType.unknown,
              ));
            }
          } else {
            return handler.next(e);
          }
        }),
      ],
    );
  return dio;
}

Future<SharedPreferences> buildSharedPreferences() async {
  return await SharedPreferences.getInstance();
}
