import 'package:flutter/material.dart';
import 'package:turfpro/models/turf/bottom_nav.dart';
import 'package:turfpro/screen/more/help_and_support.dart';
import 'package:turfpro/screen/profile_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListTile(
              context,
              icon: Icons.person,
              title: 'Profile',
              subtitle: 'Review how your profile appears to other users',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.book,
              title: 'Bookings',
              subtitle: 'View your past bookings & payments',
              onTap: () {
                // Handle bookings tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.sports_soccer,
              title: 'Games',
              subtitle: 'View your past games & other details',
              onTap: () {
                // Handle games tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.group,
              title: 'Friends and Groups',
              subtitle: 'View and manage your list of friends and groups you\'re in',
              onTap: () {
                // Handle friends and groups tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.star,
              title: 'ProPoints',
              subtitle: 'Check your earned points and redeem them for rewards',
              onTap: () {
                // Handle ProPoints tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.card_giftcard,
              title: 'Refer and Earn',
              onTap: () {
                // Handle refer and earn tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpAndSupportScreen()),
                );
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.info,
              title: 'About',
              onTap: () {
                // Handle about tap
              },
            ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(), 
    );
  }

  Widget _buildListTile(BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.greenAccent),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
    );
  }
}
