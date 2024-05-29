import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color.fromARGB(255, 212, 197, 214).withOpacity(0.1),
        filled: true,
        prefixIcon: const Icon(
          Icons.alternate_email_outlined,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
