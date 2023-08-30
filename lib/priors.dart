import 'dart:async';

import 'package:flutterfire_firestore_service/flutterfire_firestore_service.dart';
import 'package:identity_in_perception/identity_in_perception.dart';
import 'package:percepts/percepts.dart';
import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:introspection/introspection.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_service_interface/firestore_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:abstractions/beliefs.dart';

import 'home/home_screen.dart';
import 'presinter_beliefs.dart';
import 'firebase_options.dart';

Future<void> setupPriors() async {
  /// Setup FlutterFire
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Setup Locator so plugins can add SystemChecks & Routes, configure the AppState, etc.
  Locator.add<Habits>(DefaultHabits());
  Locator.add<PageGenerator>(DefaultPageGenerator());
  Locator.add<PresinterBeliefs>(PresinterBeliefs.initial);

  ///
  Locator.add<FirestoreService>(FlutterfireFirestoreService());

  /// Perform any final initialization by the app such as setting up routes.
  initializeApp();

  /// Finally, create our BeliefSystem and add to the Locator.
  final beliefSystem = DefaultBeliefSystem<PresinterBeliefs>(
      state: locate<PresinterBeliefs>(),
      errorHandlers: DefaultErrorHandlers<PresinterBeliefs>(),
      systemChecks: locate<Habits>(),
      beliefSystemFactory: ParentingBeliefSystem.new);
  Locator.add<BeliefSystem<PresinterBeliefs>>(beliefSystem);
}

void initializeApp() {
  /// Perform individual plugin initialization.
  initializeErrorHandling<PresinterBeliefs>();
  initializeAuthPlugin<PresinterBeliefs>(initialScreen: const HomeScreen());
  initializeIntrospection<PresinterBeliefs>();
  initializeFraming<PresinterBeliefs>();
}

class AstroBase extends StatelessWidget {
  const AstroBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (const bool.fromEnvironment('IN-APP-ASTRO-INSPECTOR'))
          Expanded(
            flex: 1,
            child: Material(
              child: AstroInspectorScreen(locate<IntrospectionHabit>().stream),
            ),
          ),
        Expanded(
          flex: 1,
          child: FramingBuilder<PresinterBeliefs>(
            onInit: (beliefSystem) =>
                beliefSystem.consider(const BindAuthState<PresinterBeliefs>()),
          ),
        ),
      ],
    );
  }
}
