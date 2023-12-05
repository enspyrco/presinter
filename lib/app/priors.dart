import 'dart:async';

import 'package:flutterfire_firebase_auth_for_perception/flutterfire_firebase_auth_for_perception.dart';
import 'package:flutterfire_firestore_service/flutterfire_firestore_service.dart';
import 'package:introspection/introspection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_service_interface/firestore_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:perception/perception.dart';

import '../home/home_screen.dart';
import 'app_beliefs.dart';
import '../firebase_options.dart';

Future<void> setupPriors() async {
  /// Setup FlutterFire
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Setup Locator so plugins can add SystemChecks & Routes, configure the AppState, etc.
  Locator.add<Habits>(DefaultHabits());
  Locator.add<PageGenerator>(DefaultPageGenerator());
  Locator.add<AppBeliefs>(AppBeliefs.initial);

  ///
  Locator.add<FirestoreService>(FlutterfireFirestoreService());

  /// Perform individual plugin initialization.
  initializeErrorHandling<AppBeliefs>();
  initializeIdentity<AppBeliefs>(initialScreen: const HomeScreen());
  initializeIntrospection<AppBeliefs>();
  initializeFraming<AppBeliefs>();

  /// Finally, create our BeliefSystem and add to the Locator.
  final beliefSystem = DefaultBeliefSystem<AppBeliefs>(
      beliefs: locate<AppBeliefs>(),
      errorHandlers: DefaultErrorHandlers<AppBeliefs>(),
      habits: locate<Habits>(),
      beliefSystemFactory: ParentingBeliefSystem.new);
  Locator.add<BeliefSystem<AppBeliefs>>(beliefSystem);
}

class AstroBase extends StatelessWidget {
  const AstroBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (const bool.fromEnvironment('IN-APP-INTROSPECTION'))
          Expanded(
            flex: 1,
            child: Material(
              child: IntrospectionScreen(locate<IntrospectionHabit>().stream),
            ),
          ),
        Expanded(
          flex: 1,
          child: FramingBuilder<AppBeliefs>(
            onInit: (beliefSystem) => beliefSystem.consider(
              const ObservingIdentity<AppBeliefs,
                  FlutterfireFirebaseAuthSubsystem>(),
            ),
          ),
        ),
      ],
    );
  }
}
