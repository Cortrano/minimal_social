import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_social/components/components.dart';
import 'package:minimal_social/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController repeatPasswordController =
      TextEditingController();

  void register() async {
    displayLoader(context);
    if (passwordController.text != repeatPasswordController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match!", context);
    } else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        createUserDocument(userCredential);

        if (!context.mounted) return;
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code, context);
      }

      // try {
      //   UserCredential? userCredential =
      //       await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text,
      //   );
      //   if (!context.mounted) return;
      // } on FirebaseAuthException catch (e) {
      //   displayMessage(e.code, context);
      // }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

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
                Icons.circle_outlined,
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
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10.0),
              MINTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10.0),
              MINTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10.0),
              MINTextField(
                hintText: "Repeat Password",
                obscureText: true,
                controller: repeatPasswordController,
              ),
              const SizedBox(height: 25.0),
              MINButton(text: "Register", onTap: register),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () => context.go("/login"),
                    child: const Text(
                      " Login here!",
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
