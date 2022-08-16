
class TokenState {}
class TokenStateStore extends TokenState {
  TokenStateStore({required this.refreshToken, required this.token});

  final String refreshToken;
  final String token;
}
class TokenStateExpired extends TokenState {}
