import 'package:firebase_auth/firebase_auth.dart';

class ProfileApi {
  final FirebaseAuth _auth;

  ProfileApi({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> updateName(String name) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    if (name.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }

    await user.updateDisplayName(name.trim());
    await user.reload();
  }

  Future<void> updateEmail(String email) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    await user.verifyBeforeUpdateEmail(email.trim());
  }

  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    await user.updatePassword(password);
  }
}
