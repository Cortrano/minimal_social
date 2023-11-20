import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/components/components.dart';
import 'package:minimal_social/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key}) : currentUser = FirebaseAuth.instance.currentUser;

  final User? currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0, left: 25.0),
                    child: Row(
                      children: [
                        MINBackButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24.0)),
                    padding: const EdgeInsets.all(25.0),
                    child: const Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    user!['username'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user['email'],
                    style: TextStyle(
                      color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text("No data");
          }
        },
      ),
      drawer: const MINDrawer(),
    );
  }
}
