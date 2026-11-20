import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  bool _orderUpdates = true;
  bool _promotions = false;
  bool _recommendations = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  bool _isLoading = true;

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _orderUpdates = prefs.getBool('order_updates') ?? true;
      _promotions = prefs.getBool('promotions') ?? false;
      _recommendations = prefs.getBool('recommendations') ?? true;
      _emailNotifications = prefs.getBool('email_notifications') ?? true;
      _pushNotifications = prefs.getBool('push_notifications') ?? true;
      _isLoading = false;
    });
  }

  Future<void> _updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.12),
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: primaryColor,
        secondary: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryColor, size: 21),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.notifications,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  l.manageNotifications,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.chooseNotifications,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onSurfaceVariant,
                  ),
                ),

                _buildSectionTitle(l.general, colors.onSurface),

                _buildNotificationTile(
                  title: l.orderUpdates,
                  subtitle: l.orderUpdatesDescription,
                  icon: Icons.local_shipping_outlined,
                  value: _orderUpdates,
                  onChanged: (value) {
                    setState(() => _orderUpdates = value);
                    _updateSetting('order_updates', value);
                  },
                ),

                _buildNotificationTile(
                  title: l.promotionsOffers,
                  subtitle: l.promotionsDescription,
                  icon: Icons.local_offer_outlined,
                  value: _promotions,
                  onChanged: (value) {
                    setState(() => _promotions = value);
                    _updateSetting('promotions', value);
                  },
                ),

                _buildNotificationTile(
                  title: l.recommendations,
                  subtitle: l.recommendationsDescription,
                  icon: Icons.recommend_outlined,
                  value: _recommendations,
                  onChanged: (value) {
                    setState(() => _recommendations = value);
                    _updateSetting('recommendations', value);
                  },
                ),

                _buildSectionTitle(
                  l.notificationChannels,
                  colors.onSurface,
                ),

                _buildNotificationTile(
                  title: l.pushNotifications,
                  subtitle: l.pushNotificationsDescription,
                  icon: Icons.notifications_active_outlined,
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() => _pushNotifications = value);
                    _updateSetting('push_notifications', value);
                  },
                ),

                _buildNotificationTile(
                  title: l.emailNotifications,
                  subtitle: l.emailNotificationsDescription,
                  icon: Icons.email_outlined,
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() => _emailNotifications = value);
                    _updateSetting('email_notifications', value);
                  },
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.notificationSettingsInfo,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}