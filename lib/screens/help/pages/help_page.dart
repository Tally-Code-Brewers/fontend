import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,

        title: const Text(
          'Tally CodeBrewers\'24',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[100]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildIntroText(),
                  const SizedBox(height: 20),
                  _buildFeatureCard(
                    title: '1. Online Compiler',
                    description:
                    'We’ve implemented a robust online compiler that handles all compilation processes on our local server, ensuring fast and efficient execution of code in multiple programming languages, with immediate feedback.',
                    icon: Icons.code,
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureCard(
                    title: '2. Problem Set',
                    description:
                    'We offer a rich problem set that includes easy, medium, and hard challenges, allowing users to improve their skills. Users can also add their own problems, fostering a community-driven environment.',
                    icon: Icons.book,
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureCard(
                    title: '3. Contest Platform',
                    description:
                    'Our platform hosts coding contests with a live leaderboard, creating a competitive and engaging environment. Participants can test their skills in real-time against others.',
                    icon: Icons.emoji_events,
                  ),
                  const SizedBox(height: 20),
                  _buildOverallImpact(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Text(
      'Our website for the "Tally CodeBrewers\'24" competition is an impressive blend of functionality and user engagement, designed to cater to both competitive programmers and casual coders alike. Here\'s a detailed explanation of its features:',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }

  Widget _buildFeatureCard({required String title, required String description, required IconData icon}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.deepPurpleAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallImpact() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Impact',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Our website stands out as a comprehensive tool for coding enthusiasts, offering a seamless experience from problem-solving to competitive coding. By combining an online compiler, a dynamic problem set, and a contest platform, we’ve created a space where users can learn, compete, and grow as programmers.',
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
