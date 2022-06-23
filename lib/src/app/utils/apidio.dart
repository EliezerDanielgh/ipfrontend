import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:ipfrontend/src/app/utils/preferences.dart';
import 'package:ipfrontend/src/app/utils/snackbar.dart';

abstract class APIDio {
  static const String baseURL = "http://127.0.0.1:8000/api";
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = {
      'Authorization': 'Bearer ${Preferences.getToken()}',
      'X-Dts-Schema': '${Preferences.getSchema()}',
      'accept': '*/*',
    };
    initializedInterceptors();
  }

  static initializedInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, errorHandler) async {
          print(
              'onErrorMessage: ${error.response} ${error.response?.statusCode} ${error.requestOptions.path}');
          if ((error.response?.statusCode == 403 ||
                  error.response?.statusCode == 401) &&
              error.requestOptions.path != '/token/' &&
              error.requestOptions.path != '/security/user/current/') {
            Response response = await refreshToken();
            if (response.statusCode == 200) {
              //get new tokens ...
              final data = response.data;
              Preferences.setToken(data['access'], data['refresh']);
              APIDio.configureDio();
              //create request with new access token
              final opts = Options(method: error.requestOptions.method);
              final cloneReq = await _dio.request(error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters);

              return errorHandler.resolve(cloneReq);
            }
            return errorHandler.next(error);
          } else {
            return errorHandler.next(error);
          }
        },
        onRequest: (RequestOptions request, requestHandler) {
          print("onRequest: ${request.method} ${request.uri}");
          return requestHandler.next(request);
        },
        onResponse: (response, responseHandler) {
          print('onResponse: ${response.statusCode}');
          return responseHandler.next(response);
        },
      ),
    );
  }

  static Future<Response> refreshToken() async {
    Response response;
    final refreshToken = Preferences.getRefreshToken();
    try {
      response =
          await _dio.post('/token/refresh/', data: {'refresh': refreshToken});
    } on DioError {
      rethrow;
    }
    return response;
  }

  static Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return await _dio.post(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    Response response;
    try {
      response = await _dio.get(path, queryParameters: params);
    } on DioError {
      rethrow;
    }
    return response;
  }

  Future<Response> post(String path, data) async {
    Response response;
    try {
      response = await _dio.post(path, data: data);
    } on DioError {
      rethrow;
    }

    return response;
  }

  Future<Response> put(String path, data) async {
    Response response;
    try {
      response = await _dio.put(path, data: data);
    } on DioError {
      rethrow;
    }
    return response;
  }

  Future<Response> patch(String path, data) async {
    Response response;
    try {
      response = await _dio.patch(path, data: data);
    } on DioError {
      rethrow;
    }
    return response;
  }

  Future<Response> delete(String path, {List<String>? ids}) async {
    Response response;
    try {
      if (ids == null) {
        response = await _dio.delete(path);
      } else {
        response = await _dio.delete(path, data: {'ids': ids});
      }
    } on DioError {
      rethrow;
    }
    return response;
  }

  Future<Response> uploadFile(String path, Uint8List bytes) async {
    final formData = FormData.fromMap({
      'photo': MultipartFile.fromBytes(bytes),
    });
    Response response;
    try {
      response = await _dio.patch(path, data: formData);
    } on DioError {
      rethrow;
    }
    return response;
  }
}

dynamic errorHandler(Response response) {
  switch (response.statusCode) {
    case 500:
      throw "Server Error pls retry later";
    case 403:
      throw 'Error occurred pls check internet and retry.';
    case 401:
      CustomSnackBar.error(message: response.data["detail"]);
      break;
    case 404:
      CustomSnackBar.error(
        message: 'Error occurred pls check internet and retry',
      );
      break;
    default:
      throw 'Error occurred retry';
  }
}
