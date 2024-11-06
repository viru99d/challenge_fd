import 'package:challenge_fd/modules/login/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
