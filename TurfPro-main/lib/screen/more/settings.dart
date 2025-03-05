import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListTile(
              context,
              icon: Icons.account_circle,
              title: 'Account',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.lock,
              title: 'Privacy and safety',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.data_usage,
              title: 'Data usage',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.language,
              title: 'Languages',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.help,
              title: 'Help Center',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.logout,
              title: 'Log out',
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}
