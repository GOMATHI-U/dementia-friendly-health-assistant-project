import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          _settingsTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            subtitle: "Enable or disable dark mode",
            onTap: () {
              // TODO: Implement dark mode functionality
            },
          ),
          _settingsTile(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Manage notification preferences",
            onTap: () {
              // TODO: Implement notification settings
            },
          ),
          _settingsTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "Select app language",
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          _settingsTile(
            icon: Icons.lock,
            title: "Privacy",
            subtitle: "Adjust privacy settings",
            onTap: () {
              // TODO: Implement privacy settings
            },
          ),
          _settingsTile(
            icon: Icons.info,
            title: "About",
            subtitle: "App version and details",
            onTap: () {
              // TODO: Show app details
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
