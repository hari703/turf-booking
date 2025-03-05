import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turfpro/models/turf/turf.dart';
import '../screen/turf_details/turf_details_screen.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  CustomSearchBarState createState() => CustomSearchBarState(); // FIXED HERE
}

class CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<Turf> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchTurfs(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final response = await http.get(Uri.parse('http://localhost:3000/api/turfs/search?query=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data.map((item) => Turf.fromJson(item)).toList();
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _navigateToTurfDetails(Turf turf) {
    if (!mounted) return; // Prevents navigation if the widget is unmounted
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TurfDetailsScreen(turf: turf)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _searchTurfs,
                  decoration: const InputDecoration(
                    hintText: 'Search for turfs, games',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          if (_searchResults.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final turf = _searchResults[index];
                return ListTile(
                  title: Text(turf.name),
                  onTap: () => _navigateToTurfDetails(turf),
                );
              },
            ),
        ],
      ),
    );
  }
}
