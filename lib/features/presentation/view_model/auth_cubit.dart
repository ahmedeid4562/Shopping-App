import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/auth_api.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthApi? authApi})
    : _authApi = authApi ?? AuthApi(),
      super(const AuthInitial());

  final AuthApi _authApi;

  User? get currentUser => _authApi.currentUser;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final credential = await _authApi.signUp(
        name: name,
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError('Account creation failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Account creation failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());

    try {
      final credential = await _authApi.signIn(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError('Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());

    try {
      final credential = await _authApi.signInWithGoogle();
      final user = credential?.user;

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError('Google sign in failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Google sign in failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());

    try {
      await _authApi.resetPassword(email);
      emit(const AuthPasswordResetSent());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Password reset failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());

    try {
      await _authApi.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
