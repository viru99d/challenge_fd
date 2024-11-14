import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:challenge_fd/core/constants.dart';
import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.preferences});

  final Preferences preferences;

  @override
  Future<(bool, String)> login(UserEntity user) async {
    if (user.email != Constants.text.email) {
      return (false, Constants.text.invalidEmail);
    }

    if (user.password != Constants.text.password) {
      return (false, Constants.text.invalidPassword);
    } else {
      return (true, '');
    }
  }
}
