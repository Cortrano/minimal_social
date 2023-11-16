import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_social/components/min_button.dart';
import 'package:simple_social/components/min_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80.0,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25.0),
              const Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 25.0),
              MINTextField(
                hintText: "email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10.0),
              MINTextField(
                hintText: "password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              MINButton(text: "Login", onTap: login),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () => context.go("/register"),
                    child: const Text(
                      " Register here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
