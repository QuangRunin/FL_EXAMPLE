import 'package:dio/dio.dart';
import 'package:example/core/rest_client.dart';
import 'package:example/config/config.dart';

class RestClientBase extends RestClient {
  factory RestClientBase() {
    _singleton ??=
        RestClientBase._internal(AppConfig.config.baseUrl, interceptors: null);
    return _singleton!;
  }

  RestClientBase._internal(String baseUrl, {List<Interceptor>? interceptors})
      : super(baseUrl, interceptors);

  static RestClientBase? _singleton;
}
