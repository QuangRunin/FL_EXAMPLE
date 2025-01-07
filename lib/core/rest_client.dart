// ignore_for_file: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:example/generated/locales.g.dart';

import 'api_error.dart';
import 'interceptors.dart';

class RestClient {
  RestClient(
    this.baseUrl,
    List<Interceptor>? interceptors,
    //   {
    //   Duration timeout = defaultTimeout,
    // }
  ) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      contentType: formUrlEncodedContentType,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    final CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.addAll(interceptors ??
        <Interceptor>[
          SessionInterceptor(_dio),
          ...interceptors ?? <Interceptor>[]
        ]);
  }
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const String formUrlEncodedContentType =
      'application/json;charset=UTF-8';
  final String baseUrl;
  late Dio _dio;

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      dynamic data,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> post(String path,
      {Map<String, dynamic>? formData,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.post<dynamic>(
        path,
        data: formData != null ? FormData.fromMap(formData) : data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response<dynamic> response = await _dio.patch<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<dynamic> response = await _dio.delete<dynamic>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

      return _mapResponse(response.data);
    } catch (e) {
      throw _mapError(e);
    }
  }

  ApiError _mapError(dynamic e) {
    if (e is DioException) {
      // String? code = e.response?.statusCode.toString();
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiError(
            message: LocaleKeys.unexpectedError,
            extraData: e.response?.data,
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
          return ApiError(
            errorCode: '${e.response?.data['code']}',
            message: '${e.response?.data['message']}',
            extraData: e.response?.data,
          );
        case DioExceptionType.cancel:
          return ApiError(
            errorCode: '',
            message: '',
            extraData: e.response?.data,
          );
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return const ApiError(
            message: LocaleKeys.noInternet,
          );
      }
    }

    if (e is ApiError) {
      return ApiError(errorCode: e.errorCode, message: '${e.message}');
    }

    return ApiError(
      errorCode: '${e.errorCode}',
      message: '${e.message}',
      extraData: e?.data,
    );
  }

  dynamic _mapResponse(dynamic response) {
    // if (response is Map &&
    //     ((response['success'] ?? response['Success']) as bool == false)) {
    //   throw ApiError(
    //       errorCode: '${(response['success'] ?? response['Success']) as bool?}',
    //       message: response['message'] as String?);
    // }
    if (response is Map &&
        response['error'] != '' &&
        response['error'] != null) {
      throw ApiError(
        // error: response['error'] as String?,
        message: response['message'] as String?,
        extraData: response,
      );
    }
    if (response.isEmpty) {
      throw ApiError(
        extraData: response,
      );
    }
    return response['data'] ?? response;
  }

  // String _getCode(String? code) =>
  //     (code != null && code.isNotEmpty && !code.contains('null'))
  //         ? '[$code]'
  //         : '';
}
