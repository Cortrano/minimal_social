import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/components/components.dart';
import 'package:minimal_social/components/min_post_tile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MINDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return Column(
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
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        String username = user['username'];
                        String email = user['email'];

                        return MINPostTile(
                          title: username,
                          subtitle: email,
                        );
                      }),
                ),
              ],
            );
          } else {
            return const Text("No data");
          }
        },
      ),
    );
  }
}
