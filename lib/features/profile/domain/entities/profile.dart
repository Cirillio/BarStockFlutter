class Profile {
  final String id;
  final String name;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final String role;
  final DateTime invitedAt;

  Profile({
    required this.id,
    required this.name,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.role,
    required this.invitedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'username': name,
      'full_name': fullName,
      'email': email,
      'avatar_url': avatarUrl,
      'role': role,
      'invited_at': invitedAt.toIso8601String(),
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['user_id'] as String,
      name: json['username'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
      invitedAt: DateTime.parse(json['invited_at'] as String),
    );
  }
}
