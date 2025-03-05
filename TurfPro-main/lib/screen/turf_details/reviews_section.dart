import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reviews from Google', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('4.2 ★', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Text('(235 reviews)', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),
        _buildReview('Sidharth K', 'a year ago', 5, 'Special thanks to the management for ...'),
        _buildReview('Adarsh Thiya', '2 years ago', 4, 'Great playing arena with Artificial ...'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _showFeedbackDialog(context);
          },
          child: const Text('Add Feedback'),
        ),
      ],
    );
  }

  Widget _buildReview(String name, String time, int rating, String comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(name[0]),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(rating, (index) => const Icon(Icons.star, color: Colors.yellow)),
        ),
        const SizedBox(height: 8),
        Text(comment),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    int rating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rate your experience:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      rating = index + 1;
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(hintText: 'Your feedback...'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitFeedback(rating, commentController.text);
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitFeedback(int rating, String comment) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/feedback'),
      headers: {'Content-Type': 'application/json'},
      body: {
        'rating': rating,
        'comment': comment,
      },
    );

    if (response.statusCode == 200) {
    } else {
    }
  }
}
