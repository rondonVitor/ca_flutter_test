class TokenEntity {
  final String token;

  TokenEntity({
    required this.token,
  });

  @override
  bool operator ==(covariant TokenEntity other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
