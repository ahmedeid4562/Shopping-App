import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/api/auth_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthApi _authApi = AuthApi();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscurePassword = true;

  static const Color primaryColor = Color(0xFF385CF2);

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage(l.loginEnterEmailAndPassword);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = await _authApi.signIn(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception(l.loginUnableToSignIn);
      }

      final isAdmin = await _authApi.isAdmin();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        isAdmin ? '/admin' : '/home',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-not-verified') {
        _showVerificationDialog(email, password);
      } else {
        _showMessage(_getAuthErrorMessage(e.code));
      }
    } catch (e) {
      _showMessage(l.somethingWentWrong);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return l.loginInvalidEmail;

      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return l.loginIncorrectEmailOrPassword;

      case 'user-disabled':
        return l.loginAccountDisabled;

      case 'too-many-requests':
        return l.loginTooManyAttempts;

      case 'network-request-failed':
        return l.loginCheckInternetConnection;

      default:
        return l.loginFailedTryAgain;
    }
  }

  void _showVerificationDialog(String email, String password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final dialogL = AppLocalizations.of(dialogContext)!;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(dialogL.loginEmailNotVerified),
          content: Text(dialogL.loginEmailNotVerifiedMessage(email)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(dialogL.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resendVerificationEmail(email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(dialogL.loginResendEmail),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resendVerificationEmail(String email, String password) async {
    setState(() => _isLoading = true);

    try {
      await _authApi.resendVerificationEmail(email: email, password: password);

      _showMessage(l.loginVerificationEmailSent);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-verified') {
        _showMessage(l.loginEmailAlreadyVerified);
      } else if (e.code == 'too-many-requests') {
        _showMessage(l.loginWaitBeforeRequestingEmail);
      } else if (e.code == 'invalid-credential' ||
          e.code == 'wrong-password' ||
          e.code == 'user-not-found') {
        _showMessage(l.loginIncorrectEmailOrPassword);
      } else if (e.code == 'network-request-failed') {
        _showMessage(l.loginCheckInternetConnection);
      } else {
        _showMessage(l.loginCouldNotSendVerificationEmail);
      }
    } catch (e) {
      _showMessage(l.somethingWentWrong);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _googleLogin() async {
    setState(() => _isGoogleLoading = true);

    try {
      await _authApi.signInWithGoogle();

      final isAdmin = await _authApi.isAdmin();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        isAdmin ? '/admin' : '/home',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(_getAuthErrorMessage(e.code));
    } catch (e) {
      _showMessage(l.loginGoogleFailed);
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage(l.loginEnterEmailFirst);
      return;
    }

    try {
      await _authApi.resetPassword(email);

      _showMessage(l.loginPasswordResetEmailSent);
    } on FirebaseAuthException catch (e) {
      _showMessage(_getAuthErrorMessage(e.code));
    } catch (e) {
      _showMessage(l.loginCouldNotSendPasswordResetEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = l;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 75,
                  color: primaryColor,
                ),

                const SizedBox(height: 20),

                Text(
                  localizations.loginWelcomeBack,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  localizations.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: localizations.loginEmailLabel,
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: localizations.loginPasswordLabel,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      localizations.loginForgotPassword,
                      style: const TextStyle(color: primaryColor),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading || _isGoogleLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            localizations.loginButton,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        localizations.loginOr,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 25),

                SizedBox(
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading || _isGoogleLoading
                        ? null
                        : _googleLogin,
                    icon: _isGoogleLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.g_mobiledata,
                            size: 30,
                            color: Colors.red,
                          ),
                    label: Text(
                      localizations.loginContinueWithGoogle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        localizations.loginNoAccount,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        localizations.loginSignUp,
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
