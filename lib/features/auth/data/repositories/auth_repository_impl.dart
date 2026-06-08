import 'package:hello/features/auth/data/services/firebase_auth_service.dart';
import 'package:hello/features/auth/domain/entites/auth_user.dart';
import 'package:hello/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthServices;
  AuthRepositoryImpl(this.firebaseAuthServices);

  @override
  Future<AuthUser?> getCurrentUser() async {
    // appel
    final user = await firebaseAuthServices.getUser();
    if (user != null) {
      return AuthUser(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        imageUrl: user.photoURL ?? "",
      );
    }
    return null;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    return await firebaseAuthServices.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthServices.signOut();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    await firebaseAuthServices.signUp(email, password);
  }

  @override
  Future<void> signIn(String email, String password) async {
    await firebaseAuthServices.signIn(email, password);
  }
}
