import 'package:flutter/material.dart';
import 'package:turfpro/screen/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false, 
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDB8fHR1cmZ8ZW58MHx8fHwxNjYyOTU4MjM0&ixlib=rb-1.2.1&q=80&w=1080',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/1.jpg',
                          ),
                        ),
                        const SizedBox(height: 8), 
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, 
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // User Details
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 80), // Space for the avatar
              const ListTile(
                title: Text(
                  'User Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                subtitle: Text('@username'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Bio: Love playing and booking turfs!'),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.cake),
                title: Text('Age: 25'),
              ),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location: City, Country'),
              ),
              const Divider(),
              // Interests Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Interests',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildInterestChip('Football'),
              _buildInterestChip('Cricket'),
              _buildInterestChip('Tennis'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestChip(String interest) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Chip(
        label: Text(interest),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
