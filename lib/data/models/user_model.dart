class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      role: data['role'] ?? 'user', // Default to 'user' if role is not present
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
