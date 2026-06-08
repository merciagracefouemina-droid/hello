import 'package:hello/features/auth/domain/entites/auth_user.dart';

abstract class AuthRepository {
  // creation de linterface auth Ri avec les méthodes
  // signI, signUp, signOut, signInWthGoogle et getCurrentUser

  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password, String name);
  Future<void> signOut();

  Future<AuthUser?> signInWithGoogle();
  Future<AuthUser?> getCurrentUser();
}
