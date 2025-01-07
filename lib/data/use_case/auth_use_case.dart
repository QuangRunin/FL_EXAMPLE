import 'package:dio/dio.dart';
import 'package:example/core/api_error.dart';
import 'package:example/data/repository/auth_repository.dart';
import 'package:example/data/repository_impl/auth_repository_impl.dart';

class AuthUseCase {
  final AuthRepository _repository = AuthRepositoryImpl();
  final CancelToken cancelTokenDeleteAccount = CancelToken();
  Future<void> signIn({
    required Function() onSuccess,
    required Function(ApiError err) onFailure,
  }) async {
    try {
      await _repository.signOut();
      onSuccess();
    } catch (exception) {
      onFailure(exception as ApiError);
    }
  }
}
