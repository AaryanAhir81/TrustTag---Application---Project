enum UserAccountStatus { active, blocked }

class UserModel {
  final String id;
  final String name;
  final String email;
  final int productsCount;
  final int transferCount;
  UserAccountStatus status;
  final String avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.productsCount,
    required this.transferCount,
    required this.status,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      productsCount: json['productsCount'] ?? 0,
      transferCount: json['transferCount'] ?? 0,
      status: json['status'] == 'blocked'
          ? UserAccountStatus.blocked
          : UserAccountStatus.active,
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'productsCount': productsCount,
      'transferCount': transferCount,
      'status': status.name,
      'avatarUrl': avatarUrl,
    };
  }
}
