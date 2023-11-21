import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/components/components.dart';
import 'package:minimal_social/home/data/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      final String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M I N I M A L'),
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MINDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MINTextField(
                    hintText: 'Say something..',
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                MINPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const Text('No posts.. Post something!');
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['message'];
                    String userEmail = post['userEmail'];
                    Timestamp timestamp = post['timeStamp'];

                    return MINPostTile(
                      title: message,
                      subtitle: userEmail,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
