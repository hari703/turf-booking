import 'package:flutter/material.dart';
import 'game_detail_header.dart';
import 'player_info_card.dart';
import 'query_section.dart';
import 'join_button.dart';

class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
        backgroundColor: Colors.green,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GameDetailHeader(),
              SizedBox(height: 16),
              PlayerInfoCard(),
              SizedBox(height: 16),
              QuerySection(),
              SizedBox(height: 16),
              JoinButton(),
            ],
          ),
        ),
      ),
    );
  }
}