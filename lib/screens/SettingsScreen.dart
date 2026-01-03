import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEDE9F2), // Warm White
          ),
        ),
        backgroundColor: const Color(0xFF8E6BBF), // Deep Lavender
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFEDE9F2), // Warm White
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFDED0F2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              title: const Text('Dark Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: const Text('Enable or disable dark mode'),
              secondary: const Icon(Icons.dark_mode, color: Color(0xFF8E6BBF)),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: const Color(0xFFDED0F2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SwitchListTile(
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
              title: const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: const Text('Manage notification preferences'),
              secondary: const Icon(Icons.notifications, color: Color(0xFF8E6BBF)),
            ),
          ),
          const SizedBox(height: 8),
          _settingsTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "Select app language",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language selection coming soon')));
            },
          ),
          _settingsTile(
            icon: Icons.lock,
            title: "Privacy",
            subtitle: "Adjust privacy settings",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Privacy settings coming soon')));
            },
          ),
          _settingsTile(
            icon: Icons.info,
            title: "About",
            subtitle: "App version and details",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('App details coming soon')));
            },
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFFDED0F2), // Light Lavender
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8E6BBF)), // Deep Lavender
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3E3E3E), // Dark text for readability
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF5E5E5E), // Slightly muted gray
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF8E6BBF)),
        onTap: onTap,
      ),
    );
  }
}
