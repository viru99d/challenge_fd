import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.preferences});

  final Preferences preferences;

  @override
  Future<bool> login(UserEntity user) async {
    if (user.email == '123' && user.password == '123') {
      preferences.isAuthenticated = true;
      return true;
    } else {
      return false;
    }
  }
}
