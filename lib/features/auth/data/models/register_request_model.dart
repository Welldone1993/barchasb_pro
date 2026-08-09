import '../../domain/entities/register_entity.dart';

class RegisterRequestModel extends RegisterEntity {
  RegisterRequestModel({
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.nationalId,
    required super.birthDate,
    required super.gender,
    required super.province,
    required super.city,
    required super.password,
  });

  Map<String, dynamic> toJson() => {
    'name': firstName,
    'lastName': lastName,
    'phone': phoneNumber,
    'nationalCode': nationalId,
    'birthDate': birthDate,
    'gender': gender,
    'province': province,
    'city': city,
    'password': password,
  };
}
