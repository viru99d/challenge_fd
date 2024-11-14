import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';

abstract class LoginRepository {
  Future<(bool, String)> login(UserEntity user);
}
