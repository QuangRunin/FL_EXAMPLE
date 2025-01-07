import 'package:dio/dio.dart';
import 'package:example/core/rest_client.dart';
import 'package:example/config/config.dart';

class RestClientAuth extends RestClient {
  factory RestClientAuth() {
    _singleton ??=
        RestClientAuth._internal(AppConfig.config.baseUrl, interceptors: null);
    return _singleton!;
  }

  RestClientAuth._internal(String baseUrl, {List<Interceptor>? interceptors})
      : super(baseUrl, interceptors);

  static RestClientAuth? _singleton;
}
