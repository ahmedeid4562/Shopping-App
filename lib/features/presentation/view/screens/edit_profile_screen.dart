import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/api/profile_api.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final ProfileApi _profileApi = ProfileApi();

  bool _isLoading = false;

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    _nameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage(l.pleaseLoginFirst);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final newName = _nameController.text.trim();
      final newEmail = _emailController.text.trim();

      if (newName != (user.displayName ?? '')) {
        await _profileApi.updateName(newName);
      }

      if (newEmail != (user.email ?? '')) {
        await _profileApi.updateEmail(newEmail);

        if (!mounted) return;

        _showMessage(l.verificationEmailSent);
      } else {
        if (!mounted) return;

        _showMessage(l.profileUpdatedSuccessfully);
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.editProfile,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: primaryColor.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.person_outline,
                    size: 55,
                    color: primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                l.fullName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: l.enterYourName,
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l.pleaseEnterYourName;
                  }

                  return null;
                },
              ),

              const SizedBox(height: 22),

              Text(
                l.emailAddress,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: l.enterYourEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l.pleaseEnterYourEmail;
                  }

                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                    return l.validEmailAddress;
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              Text(
                l.emailVerificationRequired,
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l.saveChanges,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
