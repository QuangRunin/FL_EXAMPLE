import 'package:example/core/rest_client_base.dart';
import 'package:example/data/repository/auth_repository.dart';
import 'package:example/global/app_url.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RestClientBase _client = RestClientBase();

  @override
  Future<void> signOut() async {
    await _client.post(AppUrl.apiLogout);
  }
}
