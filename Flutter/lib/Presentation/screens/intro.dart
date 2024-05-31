import 'package:flutter/material.dart';
import '../widgets/intro_page.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff182032),
          title: const Text(
            'Hi there',
            style: TextStyle(
              fontFamily: 'A',
              fontSize: 40,
              color: Color.fromARGB(153, 56, 231, 202),
            ),
          ),
        ),
        body: const IntroBody());
  }
}
