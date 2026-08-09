import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String phone;
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, lastName, phone, role];
}
