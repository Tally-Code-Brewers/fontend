import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_tally/screens/authentication/pages/auth_page.dart';
import 'package:project_tally/screens/home/pages/home_page.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Check if there's a signed-in user
    if (auth.currentUser != null) {
      // If user is signed in, navigate to HomePage
      return const HomePage();
    } else {
      // If no user is signed in, navigate to AuthPage
      return const AuthPage();
    }
  }
}
