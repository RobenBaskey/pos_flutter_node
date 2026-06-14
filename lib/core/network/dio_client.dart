import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:pos/core/utils/utils.dart';

import '../error/exceptions.dart';
import '../error/failure.dart';
import 'injection_container.dart';

class DioClients {
  Dio dio = getDio();

  ///Get Request handler
  Future<dynamic> get({
    required String url,
    bool isTokenRequired = false,
  }) async {
    // Prepare headers
    Map<String, dynamic> headers = await _prepareHeaders(isTokenRequired);

    // Use compute to offload the Dio request to a background isolate
    return compute(_getDataFromApi, {'url': url, 'headers': headers});
  }

  static Future<dynamic> _getDataFromApi(Map<String, dynamic> args) async {
    String url = args['url'];
    Map<String, dynamic> headers = args['headers'];

    // Prepare Dio Options with headers
    Options options = Options(
      receiveDataWhenStatusError: true,
      headers: headers,
    );

    try {
      // Make the API request using Dio
      Dio dio = Dio();
      Response response = await dio.get(url, options: options);
      return response.data;
    } on DioException catch (error) {
      if (error.error is ApiException) {
        final apiException = error.error as ApiException;
        throw Exception('API Error: ${apiException.message}');
      } else {
        throw Exception('Unexpected error occurred: ${error.message}');
      }
    }
  }

  Future<Map<String, dynamic>> _prepareHeaders(bool isTokenRequired) async {
    Map<String, dynamic> header = {};

    if (isTokenRequired) {
      var token = Utils.getToken();
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    return header;
  }

  ///Post Request handler
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    bool isTokenRequired = false,
  }) async {
    Map<String, dynamic> header = {};
    if (isTokenRequired) {
      var token = Utils.getToken();
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    Options options = Options(
      receiveDataWhenStatusError: true,
      headers: header,
    );
    try {
      Response response = await dio.post(url, data: body, options: options);
      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }

  ///Post Request handler
  Future<dynamic> postWithFile({
    required String url,
    required Map<String, dynamic> body,
    required PlatformFile file,
    required String fileKeyName,
    bool isTokenRequired = false,
  }) async {
    var token = Utils.getToken();

    var headers = <String, String>{};

    if (isTokenRequired) {
      if (token.isEmpty) {
        throw Exception("Token required");
      }

      headers = {'Authorization': 'Bearer $token'};
    }

    var data = FormData.fromMap({
      ...body,
      fileKeyName: MultipartFile.fromBytes(file.bytes!, filename: file.path),
    });

    final dio = Dio();

    final response = await dio.post(
      url,
      options: Options(headers: headers),
      data: data,
    );

    return response.data;
  }

  ///Upload gallery image
  Future<dynamic> uploadGalleryImage({
    required String url,
    required List<String> filePaths,
    required String fileKeyName,
    bool isTokenRequired = false,
  }) async {
    var token = Utils.getToken();
    if (token.isEmpty) {
      throw Exception("Token required");
    }
    var headers = {'Authorization': 'Bearer $token'};
    List<MultipartFile> files = await Future.wait(
      filePaths.map((filePath) async {
        return MultipartFile.fromFile(filePath, filename: basename(filePath));
      }),
    );

    var data = FormData.fromMap({"images[]": files});

    try {
      var dio = Dio();
      var response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );

      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }

  ///Post Request handler
  Future<dynamic> put({
    required String url,
    required Map<String, dynamic> body,
    bool isTokenRequired = false,
  }) async {
    Map<String, dynamic> header = {};
    if (isTokenRequired) {
      var token = Utils.getToken();
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    Options options = Options(
      receiveDataWhenStatusError: true,
      headers: header,
    );
    try {
      Response response = await dio.put(url, data: body, options: options);
      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }

  ///Put Request handler
  Future<dynamic> putWithFile({
    required String url,
    required Map<String, dynamic> body,
    required PlatformFile file,
    required String fileKeyName,
    bool isTokenRequired = false,
  }) async {
    var token = Utils.getToken();

    if (file.path!.isEmpty) {
      throw Exception("Please select your image");
    }

    var headers = <String, String>{};
    if (isTokenRequired) {
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      headers = {'Authorization': 'Bearer $token'};
    }

    var data = FormData.fromMap({
      ...body,
      fileKeyName: MultipartFile.fromBytes(file.bytes!, filename: file.name),
    });

    try {
      var dio = Dio();
      var response = await dio.put(
        url,
        options: Options(headers: headers),
        data: data,
      );

      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }

  ///Post Request handler
  Future<dynamic> patch({
    required String url,
    required Map<String, dynamic> body,
    bool isTokenRequired = false,
  }) async {
    Map<String, dynamic> header = {};
    if (isTokenRequired) {
      var token = Utils.getToken();
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    Options options = Options(
      receiveDataWhenStatusError: true,
      headers: header,
    );
    try {
      Response response = await dio.patch(url, data: body, options: options);
      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }

  ///delete request
  Future<dynamic> delete({
    required String url,
    bool isTokenRequired = false,
  }) async {
    Map<String, dynamic> header = {};
    if (isTokenRequired) {
      var token = Utils.getToken();
      if (token.isEmpty) {
        throw Exception("Token required");
      }
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      header = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    Options options = Options(
      receiveDataWhenStatusError: true,
      headers: header,
    );
    try {
      Response response = await dio.delete(url, options: options);
      return response.data;
    } on DioException catch (error) {
      var apiException = DioErrorHandler.handleError(error);
      throw apiException;
    }
  }
}
