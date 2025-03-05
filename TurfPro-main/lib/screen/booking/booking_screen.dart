import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/booking.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  String selectedSport = 'Football';
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> availableSlots = [];
  String? selectedSlotId;
  bool isFullCourt = false;
  String? userId;

  final Color whatsAppGreen = const Color(0xFF25D366);
  final Color whatsAppLightGreen = const Color(0xFF25D366);

  Future<void> fetchUserId() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/user/me'));
    if (response.statusCode == 200) {
      setState(() {
        userId = json.decode(response.body)['id']; // Adjust based on your response structure
      });
    } else {
      // Handle error
    }
  }

  Future<void> fetchAvailableSlots() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/bookings/slots?sport=$selectedSport&date=${selectedDate.toIso8601String()}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        availableSlots = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
    }
  }

  Future<void> bookSlot() async {
    if (selectedSlotId == null || userId == null) return;

    final booking = Booking(
      userId: userId!,
      slotId: selectedSlotId!,
      selectedSport: selectedSport,
      selectedDate: selectedDate,
      selectedTimeSlot: 'selectedTimeSlot', // Set the selected time slot based on user selection
      isFullCourt: isFullCourt,
      subTotal: 1000,
      discount: 200,
      payableAmount: 800,
      advancePayment: 500,
    );

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(booking.toJson()),
    );
    if (response.statusCode == 201) {
      // Handle success
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserId();
    fetchAvailableSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AZCO Gamers Arena'),
        backgroundColor: whatsAppGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose your sport', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _buildSportChip('Football', Icons.sports_soccer),
                _buildSportChip('Cricket', Icons.sports_cricket),
                _buildSportChip('Billiards', Icons.sports_handball),
                _buildSportChip('Badminton', Icons.sports_tennis),
                _buildSportChip('Table Tennis', Icons.sports_tennis),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Select date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: '${selectedDate.toLocal()}'.split(' ')[0],
                suffixIcon: Icon(Icons.calendar_today, color: whatsAppGreen),
                border: const OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                    fetchAvailableSlots();
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            const Text('Available time slots', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: availableSlots.map((slot) {
                return ListTile(
                  title: Text(slot['time']),
                  trailing: Radio<String>(
                    value: slot['_id'],
                    groupValue: selectedSlotId,
                    onChanged: (String? value) {
                      setState(() {
                        selectedSlotId = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Select court size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildCourtSizeChip('Half court', false),
                const SizedBox(width: 10),
                _buildCourtSizeChip('Full court', true),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: bookSlot,
                style: ElevatedButton.styleFrom(backgroundColor: whatsAppGreen),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportChip(String sport, IconData icon) {
    return ChoiceChip(
      label: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(sport),
        ],
      ),
      selected: selectedSport == sport,
      onSelected: (selected) {
        setState(() {
          selectedSport = sport;
          fetchAvailableSlots();
        });
      },
    );
  }

  Widget _buildCourtSizeChip(String label, bool fullCourt) {
    return ChoiceChip(
      label: Text(label),
      selected: isFullCourt == fullCourt,
      onSelected: (selected) {
        setState(() {
          isFullCourt = fullCourt;
        });
      },
    );
  }
}
