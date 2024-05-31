import 'package:flutter_application_1/application/Providers/signup_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/username.dart';
import 'package:flutter/material.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final passwordTextFieldKey = GlobalKey<FormFieldState>();
    final usernameKey = GlobalKey<FormFieldState>();

    return Scaffold(
      body: Builder(builder: (cont) {
        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.black, Colors.black12],
            begin: Alignment.bottomCenter,
            end: Alignment(0, 0.7),
          ).createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/two.JPG"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const Text(
                    "Create your account",
                    style: TextStyle(color: Color.fromARGB(232, 241, 216, 216)),
                  ),
                  const SizedBox(height: 20),
                  UsernameTextField(controller: usernameController),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 170, 95, 184)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(134, 218, 213, 213),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: passwordTextFieldKey,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
                      helperText: '*Password must contain special character',
                      helperStyle: const TextStyle(
                          color: Color.fromARGB(158, 76, 175, 79)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 170, 95, 184)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Color.fromARGB(134, 218, 213, 213),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: confirmController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.blue.withOpacity(0.6)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 170, 95, 184)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Color.fromARGB(134, 218, 213, 213),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      String username = usernameController.text;

                      await ref
                          .read(SignupStateProvider.notifier)
                          .signup(email, password, username);

                      final dynamic signupState =
                          ref.watch(SignupStateProvider);
                      if (signupState.containsKey("error")) {
                        ScaffoldMessenger.of(cont).showSnackBar(SnackBar(
                          content: Text('${signupState['error']}'),
                          duration: const Duration(seconds: 5),
                        ));
                      } else {
                        GoRouter.of(context).go('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color.fromARGB(92, 255, 255, 255)
                            .withOpacity(0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed:
                          () {}, //here will be what it shows when trying to continue with google
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/google.png'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 18),
                          const Text(
                            "Sign In with Google",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go("/login");
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 170, 250),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
