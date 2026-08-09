class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String phone;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
