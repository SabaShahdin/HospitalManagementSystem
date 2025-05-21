import 'package:flutter/material.dart';
import 'singUp.dart'; // Make sure this matches your actual file and class name
import 'AdminSignUp.dart';
import 'RoleloginScreen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void navigateToRolePage(BuildContext context, String role) {
    if (role == "Admin") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminSignupScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoleLoginScreen(role: role),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text("Select Your Role"),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hospital Logo
              SizedBox(
                height: 100,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Continue as:",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

              // Role Buttons
              RoleButton(
                  label: "Admin",
                  onTap: () => navigateToRolePage(context, "Admin")),
              const SizedBox(height: 15),
              RoleButton(
                  label: "Doctor",
                  onTap: () => navigateToRolePage(context, "Doctor")),
              const SizedBox(height: 15),
              RoleButton(
                  label: "Patient",
                  onTap: () => navigateToRolePage(context, "Patient")),
              const SizedBox(height: 15),
              RoleButton(
                  label: "Nurse",
                  onTap: () => navigateToRolePage(context, "Nurse")),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const RoleButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full-width button
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
