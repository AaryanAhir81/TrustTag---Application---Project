class AdminProfileModel {
  String name;
  String email;
  String phone;
  String role;

  AdminProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) {
    return AdminProfileModel(
      name: json['name'] ?? 'Aaryan Ahir',
      email: json['email'] ?? 'admin@gmail.com',
      phone: json['phone'] ?? '+91 XXXXX XXXXX',
      role: json['role'] ?? 'Administrator',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}
