import 'user_entity.dart';

class LoginEntity {
  final String message;
  final UserEntity user;
  final String token;

  const LoginEntity({
    required this.token,
    required this.user,
    required this.message,
  });
}
