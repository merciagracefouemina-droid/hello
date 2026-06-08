// bloc pour la gestion de l'authentification

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    // separe les fonctions de chaque event dans des fonctions privées
    on<AuthInitialEvent>(onAuthInitial);
    on<AuthLoginEvent>(onAuthLogin);
    on<AuthSignUpEvent>(onAuthSignUp);
    on<AuthSignInWithGoogleEvent>(onAuthSignInWithGoogle);
    on<AuthSignOutEvent>(onAuthSignOut);
    on<AuthCheckConnectionEvent>(onAuthCheckConnection);
  }

  Future<void> onAuthInitial(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthauthenticatedState(user.id));
      } else {
        emit(AuthUnauthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> onAuthLogin(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await authRepository.signIn(event.email, event.password);
      emit(AuthauthenticatedState(event.email));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> onAuthSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await authRepository.signUp(event.email, event.password, event.name);
      emit(AuthauthenticatedState(event.email));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> onAuthSignInWithGoogle(
    AuthSignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(AuthErrorState("Aucune connexion Internet"));
        return;
      }

      final user = await authRepository.signInWithGoogle();

      if (user != null) {
        emit(AuthauthenticatedState(user.id));
      } else {
        emit(AuthUnauthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> onAuthSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> onAuthCheckConnection(
    AuthCheckConnectionEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final resul = await Connectivity().checkConnectivity();
      if (resul.contains(ConnectivityResult.none)) {
        emit(AuthCheckConnectionState());
        emit(AuthErrorState("Pas de connexion"));
        return;
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
