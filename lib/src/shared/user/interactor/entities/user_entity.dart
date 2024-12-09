class UserEntity {
  final String username;
  final String password;

  UserEntity({
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
