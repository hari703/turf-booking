import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turfpro/models/turf/turf.dart';

class TurfsScreen extends StatefulWidget {
  const TurfsScreen({super.key});

  @override
  TurfsScreenState createState() => TurfsScreenState();
}

class TurfsScreenState extends State<TurfsScreen> {
  List<Turf> turfs = [];

  @override
  void initState() {
    super.initState();
    fetchTurfs();
  }

  Future<void> fetchTurfs() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/turf'));
    if (response.statusCode == 200) {
      List<dynamic> turfList = json.decode(response.body);
      setState(() {
        turfs = turfList.map((turf) => Turf(
          id: turf['_id'],
          name: turf['name'],
          imageUrl: turf['imageUrl'],
          games: turf['games'],
          location: turf['location'],
          openHours: turf['openHours'],
          discount: turf['discount'],
          rating: turf['rating'],
        )).toList();
      });
    }
  }

  Future<void> addTurf(String name, String games, String location, String openHours, String discount, double rating, String imageUrl) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/api/turf/addTurf'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'games': games,
      'location': location,
      'openHours': openHours,
      'discount': discount,
      'rating': rating,
      'imageUrl': imageUrl,
    }),
  );

  if (!mounted) return; // ✅ Fix: Ensure widget is still mounted

  if (response.statusCode == 201) {
    fetchTurfs();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Turf added successfully!')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to add turf.')),
    );
  }
}


  void showAddTurfDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController gamesController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController openHoursController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: const Text('Add Turf', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(nameController, 'Name', Icons.business),
                  _buildTextField(gamesController, 'Games', Icons.sports_soccer),
                  _buildTextField(locationController, 'Location', Icons.location_on),
                  _buildTextField(openHoursController, 'Open Hours', Icons.access_time),
                  _buildTextField(discountController, 'Discount', Icons.discount),
                  _buildTextField(ratingController, 'Rating', Icons.star, isNumber: true),
                  _buildTextField(imageUrlController, 'Image URL', Icons.image),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                addTurf(
                  nameController.text,
                  gamesController.text,
                  locationController.text,
                  openHoursController.text,
                  discountController.text,
                  double.tryParse(ratingController.text) ?? 0,
                  imageUrlController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add Turf'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(icon, color: Colors.green),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turfs'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: showAddTurfDialog,
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFE8F5E9),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemCount: turfs.length,
          itemBuilder: (context, index) {
            var turf = turfs[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(turf.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(turf.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(turf.games),
                        Text(turf.location),
                        Text(turf.openHours),
                        Text(turf.discount),
                        Text('${turf.rating} ★', style: const TextStyle(color: Colors.orange)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
