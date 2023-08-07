import 'package:auth_for_perception/auth_for_perception.dart';
import 'package:error_handling_for_perception/error_handling_for_perception.dart';
import 'package:navigation_for_perception/navigation_for_perception.dart';
import 'package:types_for_perception/auth_beliefs.dart';
import 'package:types_for_perception/beliefs.dart';
import 'package:types_for_perception/error_handling_types.dart';
import 'package:types_for_perception/navigation_types.dart';

class AppState
    implements
        CoreBeliefs,
        AppStateNavigation,
        AppStateErrorHandling,
        AuthConcept {
  AppState({
    required this.auth,
    required this.error,
    required this.navigation,
  });

  @override
  final AuthBeliefs auth;
  @override
  final DefaultErrorHandlingState error;
  @override
  final DefaultNavigationState navigation;

  static AppState get initial => AppState(
        auth: AuthBeliefSystem.initialBeliefs(),
        error: DefaultErrorHandlingState.initial,
        navigation: DefaultNavigationState.initial,
      );

  @override
  AppState copyWith({
    DefaultNavigationState? navigation,
    DefaultErrorHandlingState? error,
    AuthBeliefs? auth,
  }) =>
      AppState(
        navigation: navigation ?? this.navigation,
        auth: auth ?? this.auth,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'navigation': navigation.toJson(),
        'auth': auth.toJson(),
        'error': error.toJson(),
      };
}
