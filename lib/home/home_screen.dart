import 'package:flutterfire_firebase_auth_for_perception/flutterfire_firebase_auth_for_perception.dart';
import 'package:flutter/material.dart';

import '../presinter_beliefs.dart';
import 'role_selector.dart';
import 'sessions_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: const [
            AvatarMenuButton<PresinterBeliefs>(
              options: {
                MenuOption('Sign Out', SignOut<PresinterBeliefs>()),
              },
            )
          ],
        ),
        body: const Center(
          child: Row(children: [RoleSelector(), SessionsView()]),
        ));
  }
}
