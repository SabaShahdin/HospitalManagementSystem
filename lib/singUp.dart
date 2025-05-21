import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  final String role;

  const Signup({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup - $role"),
      ),
      body: Center(
        child: Text(
          "Signup Page for $role",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
