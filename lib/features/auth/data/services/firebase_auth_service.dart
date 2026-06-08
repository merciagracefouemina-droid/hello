import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello/features/auth/domain/entites/auth_user.dart';

class FirebaseAuthService {
  // initialisation des intances de FirebaseAuth et GoogleSignIn
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // get current pour User
  Future<User?> getUser() async {
    return firebaseAuth.currentUser;
  }

  // méthode pour se connecter avec email et mot de passe
  Future<void> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // méthode pour s'inscrire avec email et mot de passe
  Future<void> signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  // méthode pour se connecter avec Google web et mobile complet ensemble pour éviter les problèmes de compatibilité
  Future<AuthUser?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Sign in with Google on web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await firebaseAuth.signInWithPopup(googleProvider);
      } else {
        // Sign in with Google on mobile
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          throw Exception('Google sign in aborted');
        }
        //  ici il permet de d'identifier les utilisateurs
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final credential = await firebaseAuth.signInWithCredential(
          authCredential,
        );

        final user = credential.user;

        if (user == null) return null;

        return AuthUser(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          imageUrl: user.photoURL ?? '',
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception('Failed to sign in with Google:$e ');
    }
  }
}
