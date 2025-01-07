import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example/core/api_error.dart';
import 'package:example/base/cache_manager.dart';
import 'package:example/common/utils/functions.dart';
import 'package:example/global/app_log.dart';
// import 'package:example/global/app_url.dart';
// import 'package:get/get.dart' as g;

class SessionInterceptor with CacheManager implements InterceptorsWrapper {
  SessionInterceptor(this.dio);
  final Dio dio;

  final List<String> listApi = [
    ' AppUrl.terms',
  ].map((e) => '/api/$e').toList();
  Future<void>? _refreshTokenFuture;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response?.statusCode == 500) {
        AppLog.err('=======> [Server Error][${err.message}] <=======');
      } else {
        AppLog.err(
            '=======> #[DioError][${err.response?.statusCode}][${err.response?.realUri.path}] ${err.response} <=======');
        // if (err.response?.statusCode == 401) {
        //   if (getToken() != null &&
        //       err.response?.data['message'] == 'Token invalid') {
        //     _handleRefreshToken(err, handler);
        //   }
        // }
      }
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLog.dbPrint(
        '=======> ${options.method} ${options.baseUrl}${options.path}');
    options.headers.addAll(
      <String, dynamic>{'Accept': 'application/json'},
    );
    // if (getToken() != null) {
    //   options.headers.addAll(
    //     <String, dynamic>{'Authorization': 'Bearer ${getToken()}'},
    //   );
    // }
    AppLog.dbPrint('=======> HEADER: ${options.headers}');

    if (options.data != null) {
      AppLog.dbPrint('=======> [REQUEST DATA]: ${options.data}');
    } else if (options.queryParameters.isNotEmpty) {
      AppLog.dbPrint(
          '=======> [REQUEST queryParameters]: ${options.queryParameters}');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    AppLog.success(
        '<=== ${response.statusCode} [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    if (response.requestOptions.data != null) {
      AppLog.success('<=== [RESPONSE DATA]: ${response.requestOptions.data}');
    } else if (response.requestOptions.queryParameters.isNotEmpty) {
      AppLog.success(
          '<=== [RESPONSE queryParameters]: ${response.requestOptions.queryParameters}');
    }

    if (response.data is String && isNotNullOrEmpty(response.data)) {
      response.data = jsonDecode(response.data as String);
    }
    if (response.data is Map || response.data is List) {
      AppLog.success(jsonEncode(response.data));
    } else {
      AppLog.success('${response.data}');
    }

    return handler.next(response);
  }

  void _handleRefreshToken(DioException err, ErrorInterceptorHandler handler) {
    _refreshTokenFuture ??= _onRefreshToken(onSuccess: (String token) {
      _retry(requestOptions: err.requestOptions, token: token).then((response) {
        handler.resolve(response);
      }).catchError((e) {
        handler.reject(e);
      });
    }, onErr: (ApiError err) {
      _refreshTokenFuture = null;
    });
  }

  Future<Response<dynamic>> _retry({
    required RequestOptions requestOptions,
    required String token,
  }) {
    final options = Options(method: requestOptions.method);
    options.headers?.addAll(
      <String, dynamic>{'content-type': 'application/json'},
    );
    options.headers?.addAll(
      <String, dynamic>{'Authorization': 'Bearer $token'},
    );
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  void handleError({required int code, String path = ''}) {
    switch (code) {}
  }

  Future<void> _onRefreshToken({
    required Function(String token) onSuccess,
    required Function(ApiError err) onErr,
  }) async {
    //   final AuthUseCase authUseCase = AuthUseCase();
    //   authUseCase.refreshToken(
    //     onSuccess: (SignInResult data) {
    //       if (isNotNullOrEmpty(data.token)) {
    //         saveToken(data.token);
    //         onSuccess(data.token!);
    //       }
    //     },
    //     onFailure: (ApiError err) async {
    //       onErr(err);
    //       await removeAllCache();
    //       if (g.Get.currentRoute != AppRouter.routerStart) {
    //         g.Get.offAllNamed(AppRouter.routerStart);
    //       }
    //     },
    //   );
  }
}
