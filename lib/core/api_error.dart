import 'api_response.dart';

class ApiError {
  const ApiError({
    this.errorCode,
    this.message,
    this.extraData,
  });

  ApiError.fromResponse(ApiResponse response)
      : errorCode = response.errorCode,
        message = response.message,
        extraData = response.data;
  final String? errorCode;
  final String? message;
  final dynamic extraData;
}
