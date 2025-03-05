import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListTile(
              context,
              icon: Icons.question_answer,
              title: 'FAQs',
              onTap: () {
                // Navigate to FAQs
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.contact_support,
              title: 'Contact Support',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.forum,
              title: 'Community Resources',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.policy,
              title: 'Privacy Policy',
              onTap: () {
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.announcement,
              title: 'Terms of Service',
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
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}
