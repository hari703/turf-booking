import 'package:flutter/material.dart';

class NearbyGames extends StatelessWidget {
  const NearbyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        GameCard(
          title: 'Cricket',
          host: 'Abhidev P',
          distance: '2 km',
          time: '8 AM - 9 AM',
          participants: '4/10 Going',
          fee: '₹100 per head',
          imageUrl: 'https://imgs.search.brave.com/QEUcih--sNhZ2tW9kF612ZhJqBsWAZQNz2NRcrH2P0U/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuYXVndXN0bWFu/LmNvbS93cC1jb250/ZW50L3VwbG9hZHMv/c2l0ZXMvNi8yMDIz/LzA0LzE2MDcyNjQ5/L1VudGl0bGVkLWRl/c2lnbi0yMDIzLTA0/LTE2VDA3MTMxOS4y/MTQuanBn', // Replace with your image URL
        ),
        GameCard(
          title: 'Football',
          host: 'Neeraj T',
          distance: '3.72 km',
          time: 'Today, 7:30 PM',
          participants: '7 Going',
          location: 'ESSOS Sports Arena, Hebbal',
          status: 'BOOKED',
          imageUrl: 'https://imgs.search.brave.com/ph3o5CenFYcdjiGczU6GcU2UyUoqopdkJuLL3liLGnQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9m/cm9udC12aWV3LXNw/b3J0cy1zdGFkaXVt/LXdpdGgtbGlnaHRz/LWJhY2tncm91bmRf/MTQwOS00NzUwLmpw/Zz9zaXplPTYyNiZl/eHQ9anBn', 
        ),
        // Add more GameCards here as needed
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String host;
  final String distance;
  final String time;
  final String participants;
  final String fee;
  final String location;
  final String status;
  final String imageUrl; 

  const GameCard({
    super.key,
    required this.title,
    required this.host,
    required this.distance,
    required this.time,
    required this.participants,
    this.fee = '',
    this.location = '',
    this.status = '',
    required this.imageUrl, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 4),
                    Text('Host: $host'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text('Distance: $distance'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text('Time: $time'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.group, size: 16),
                    const SizedBox(width: 4),
                    Text('Participants: $participants'),
                  ],
                ),
                if (fee.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, size: 16),
                      const SizedBox(width: 4),
                      Text('Fee: $fee'),
                    ],
                  ),
                ],
                if (location.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place, size: 16),
                      const SizedBox(width: 4),
                      Text('Location: $location'),
                    ],
                  ),
                ],
                if (status.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text('Status: $status', style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
