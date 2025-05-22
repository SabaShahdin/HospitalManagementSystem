import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  State<AdminSignupScreen> createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); // Reserved for future use
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> registerAdmin() async {
    if (!_formKey.currentState!.validate()) return;

    final String email = emailController.text.trim();
    final String name = nameController.text.trim();
    final String contact = contactController.text.trim();
    final String department = "Management"; // Hardcoded

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/admin/register'), // Use correct IP
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'name': name,
          'contactNumber': contact,
          'department': department,
        }),
      );

      final resData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resData['message'] ?? 'Admin registered!')),
        );
        emailController.clear();
        nameController.clear();
        contactController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resData['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return emailRegex.hasMatch(value) ? null : 'Enter a valid email';
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }

  String? validateContact(String? value) {
    if (value == null || value.isEmpty) return 'Contact number is required';
    final contactRegex = RegExp(r'^\d{10,15}$');
    return contactRegex.hasMatch(value) ? null : 'Enter a valid contact number';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text("Admin Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Create Admin Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: contactController,
                  decoration: const InputDecoration(
                    labelText: "Contact Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: validateContact,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : registerAdmin,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign Up"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
