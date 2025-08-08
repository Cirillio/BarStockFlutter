class UserEntity {
  final String id;
  final String email;
  final String name;

  const UserEntity({required this.id, required this.email, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name};
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }
}
