import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    try {
      await credential.user?.updateDisplayName(name.trim());
      await credential.user?.sendEmailVerification();

      await _auth.signOut();

      return credential;
    } catch (e) {
      await _auth.signOut();
      rethrow;
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    try {
      await credential.user?.reload();

      final user = _auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found.',
        );
      }

      if (!user.emailVerified) {
        await _auth.signOut();

        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before logging in.',
        );
      }

      return credential;
    } catch (e) {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    await _googleSignIn.initialize();

    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<bool> isAdmin() async {
    final user = _auth.currentUser;

    if (user == null) return false;

    final tokenResult = await user.getIdTokenResult(true);

    return tokenResult.claims?['admin'] == true;
  }

  Future<bool> isUserAdmin(User user) async {
    final tokenResult = await user.getIdTokenResult(true);

    return tokenResult.claims?['admin'] == true;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> resendVerificationEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await credential.user?.reload();

      final user = _auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found.',
        );
      }

      if (user.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-already-verified',
          message: 'Your email is already verified.',
        );
      }

      await user.sendEmailVerification();
    } finally {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }
    }
  }

  Future<bool> checkEmailVerified() async {
    final user = _auth.currentUser;

    if (user == null) return false;

    await user.reload();

    return _auth.currentUser?.emailVerified ?? false;
  }

  User? get currentUser => _auth.currentUser;
}
