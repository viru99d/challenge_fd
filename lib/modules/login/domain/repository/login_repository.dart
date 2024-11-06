import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';

abstract class LoginRepository {
  Future<bool> login(UserEntity user);
}
