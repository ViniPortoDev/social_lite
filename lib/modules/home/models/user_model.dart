class UserModel {
  final int id;
  final String name;
  final String username;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
    );
  }
}

