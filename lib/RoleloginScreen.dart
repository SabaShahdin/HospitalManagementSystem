import 'package:flutter/material.dart';

class RoleLoginScreen extends StatelessWidget {
  final String role;

  const RoleLoginScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("$role Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Login as $role", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add Firebase/DB login logic and role validation
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
