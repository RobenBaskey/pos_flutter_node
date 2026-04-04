import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/utils.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        Utils.customPrint(tag: "API URL: ", '${options.uri}');
        Utils.customPrint(tag: "HEADER: ", options.headers);
        Utils.customPrint(tag: "REQUEST BODY: ", jsonEncode(options.data));
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        Utils.customPrint(tag: "API RESPONSE: ", response.data);
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        Utils.customPrint(
          tag: "STATUS CODE: ",
          "${error.response?.statusCode ?? ""}",
        );
        Utils.customPrint(tag: "ERROR DATA: ", "${error.response?.data ?? ""}");
        return handler.next(error);
      },
    ),
  );

  return dio;
}
