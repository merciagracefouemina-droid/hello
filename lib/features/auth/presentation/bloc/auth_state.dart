abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthauthenticatedState extends AuthState {
  final String userId;
  AuthauthenticatedState(this.userId);
}

class AuthUnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}

class AuthCheckConnectionState extends AuthState {}
