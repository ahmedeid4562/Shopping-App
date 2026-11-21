import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../core/theme/locale_controller.dart';
import '../../../../l10n/app_localizations.dart';
import 'orders_screen.dart';
import 'edit_profile_screen.dart';
import 'my_addresses_screen.dart';
import 'payment_methods_screen.dart';
import 'notifications_screen.dart';
import 'help_support_screen.dart';
import 'about_app_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final themeController = ThemeController.instance;
    final name = user?.displayName ?? l10n.user;
    final email = user?.email ?? l10n.noEmailAvailable;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myProfile), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(name, email, user?.photoURL),
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.myAccount),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: l10n.editProfile,
            subtitle: l10n.updatePersonalInfo,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.lock_outline,
            title: l10n.changePassword,
            subtitle: l10n.updateAccountPassword,
            onTap: () => _changePassword(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.shopping_bag_outlined,
            title: l10n.myOrders,
            subtitle: l10n.viewOrderHistory,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.location_on_outlined,
            title: l10n.myAddresses,
            subtitle: l10n.manageAddresses,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyAddressesScreen()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.payment_outlined,
            title: l10n.paymentMethods,
            subtitle: l10n.managePaymentOptions,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
              );
            },
          ),
          const AdminDashboardMenuItem(),
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.preferences),
          AnimatedBuilder(
            animation: themeController,
            builder: (context, child) {
              final isDark = themeController.isDarkMode;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: _cardDecoration(context),
                child: SwitchListTile(
                  secondary: _buildIcon(Icons.dark_mode_outlined),
                  title: Text(l10n.darkMode),
                  subtitle: Text(
                    isDark
                        ? l10n.darkAppearanceEnabled
                        : l10n.lightAppearanceEnabled,
                  ),
                  value: isDark,
                  activeThumbColor: primaryColor,
                  onChanged: (value) => themeController.toggleTheme(value),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: LocaleController.instance,
            builder: (context, child) {
              final currentLocale =
                  LocaleController.instance.locale.languageCode;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: _cardDecoration(context),
                child: Row(
                  children: [
                    _buildIcon(Icons.language),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.language,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentLocale == 'ar' ? l10n.arabic : l10n.english,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownButton<String>(
                      value: currentLocale,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(l10n.english),
                        ),
                        DropdownMenuItem(value: 'ar', child: Text(l10n.arabic)),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          LocaleController.instance.changeLocale(value);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.notifications_outlined,
            title: l10n.notifications,
            subtitle: l10n.manageNotifications,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.support),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: l10n.helpSupport,
            subtitle: l10n.getHelpAccount,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: l10n.aboutApp,
            subtitle: l10n.learnAboutApp,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutAppScreen()),
              );
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              '${l10n.appTitle} v1.0.0',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String name, String email, String? photoUrl) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: photoUrl != null
                    ? NetworkImage(photoUrl)
                    : null,
                child: photoUrl == null
                    ? Text(
                        name.isNotEmpty ? name[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.shoppingMember,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _cardDecoration(context),
      child: ListTile(
        leading: _buildIcon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: primaryColor, size: 22),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.pleaseLoginAgain)));
      return;
    }

    final hasPasswordProvider = user.providerData.any(
      (provider) => provider.providerId == 'password',
    );

    if (!hasPasswordProvider) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.accountNoEmailPassword)));
      return;
    }

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool currentVisible = false;
    bool newVisible = false;
    bool confirmVisible = false;
    bool isLoading = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContentContext, setDialogState) {
            return AlertDialog(
              title: Text(l10n.changePassword),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: !currentVisible,
                      decoration: InputDecoration(
                        labelText: l10n.currentPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            currentVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              currentVisible = !currentVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: newPasswordController,
                      obscureText: !newVisible,
                      decoration: InputDecoration(
                        labelText: l10n.newPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            newVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              newVisible = !newVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: !confirmVisible,
                      decoration: InputDecoration(
                        labelText: l10n.confirmNewPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            confirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              confirmVisible = !confirmVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final currentPassword = currentPasswordController.text
                              .trim();
                          final newPassword = newPasswordController.text.trim();
                          final confirmPassword = confirmPasswordController.text
                              .trim();

                          String? errorMessage;

                          if (currentPassword.isEmpty ||
                              newPassword.isEmpty ||
                              confirmPassword.isEmpty) {
                            errorMessage = l10n.fillAllFields;
                          } else if (newPassword.length < 6) {
                            errorMessage = l10n.passwordMinLength;
                          } else if (newPassword != confirmPassword) {
                            errorMessage = l10n.passwordsDoNotMatch;
                          } else if (currentPassword == newPassword) {
                            errorMessage = l10n.newPasswordDifferent;
                          }

                          if (errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                            return;
                          }

                          setDialogState(() {
                            isLoading = true;
                          });

                          try {
                            final credential = EmailAuthProvider.credential(
                              email: user.email!,
                              password: currentPassword,
                            );

                            await user.reauthenticateWithCredential(credential);

                            await user.updatePassword(newPassword);

                            if (!dialogContext.mounted) return;

                            Navigator.pop(dialogContext);

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.passwordChangedSuccessfully),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            String message;

                            switch (e.code) {
                              case 'wrong-password':
                              case 'invalid-credential':
                                message = l10n.incorrectCurrentPassword;
                                break;
                              case 'weak-password':
                                message = l10n.chooseStrongerPassword;
                                break;
                              case 'requires-recent-login':
                                message = l10n.pleaseLoginAgain;
                                break;
                              default:
                                message = l10n.somethingWentWrong;
                            }

                            if (dialogContext.mounted) {
                              setDialogState(() {
                                isLoading = false;
                              });

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            }
                          } catch (e) {
                            if (dialogContext.mounted) {
                              setDialogState(() {
                                isLoading = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.somethingWentWrong),
                                ),
                              );
                            }
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.changePassword),
                ),
              ],
            );
          },
        );
      },
    );

    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.logout),
          content: Text(l10n.logoutConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l10n.logout,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await FirebaseAuth.instance.signOut();

      if (!context.mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.logoutFailed)));
    }
  }
}

class AdminDashboardMenuItem extends StatefulWidget {
  const AdminDashboardMenuItem({super.key});

  @override
  State<AdminDashboardMenuItem> createState() => _AdminDashboardMenuItemState();
}

class _AdminDashboardMenuItemState extends State<AdminDashboardMenuItem> {
  bool _isAdmin = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkAdminAccess();
  }

  Future<void> _checkAdminAccess() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        if (mounted) {
          setState(() {
            _isChecking = false;
          });
        }
        return;
      }

      final tokenResult = await user.getIdTokenResult(true);
      final claims = tokenResult.claims;

      if (!mounted) return;

      setState(() {
        _isAdmin = claims?['admin'] == true;
        _isChecking = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isAdmin = false;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking || !_isAdmin) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.admin_panel_settings_outlined,
            color: Colors.orange,
          ),
        ),
        title: Text(
          l10n.adminDashboard,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(l10n.manageStoreOrders),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.admin);
        },
      ),
    );
  }
}
