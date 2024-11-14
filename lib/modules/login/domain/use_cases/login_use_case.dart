import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';
import 'package:challenge_fd/modules/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<(bool, String)> call(UserEntity user) async {
    return await repository.login(user);
  }
}
