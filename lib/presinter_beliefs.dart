import 'package:identity_in_perception/identity_in_perception.dart';
import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:abstractions/identity.dart';
import 'package:abstractions/beliefs.dart';
import 'package:abstractions/error_correction.dart';
import 'package:abstractions/framing.dart';

class PresinterBeliefs
    implements
        CoreBeliefs,
        FramingConcept,
        ErrorCorrectionConcept,
        IdentityConcept {
  PresinterBeliefs({
    required this.auth,
    required this.error,
    required this.framing,
  });

  @override
  final IdentityBeliefs auth;
  @override
  final DefaultErrorCorrectionBeliefs error;
  @override
  final DefaultFramingBeliefs framing;

  static PresinterBeliefs get initial => PresinterBeliefs(
        auth: AuthBeliefSystem.initialBeliefs(),
        error: DefaultErrorCorrectionBeliefs.initial,
        framing: DefaultFramingBeliefs.initial,
      );

  @override
  PresinterBeliefs copyWith({
    DefaultFramingBeliefs? framing,
    DefaultErrorCorrectionBeliefs? error,
    IdentityBeliefs? auth,
  }) =>
      PresinterBeliefs(
        framing: framing ?? this.framing,
        auth: auth ?? this.auth,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'navigation': framing.toJson(),
        'auth': auth.toJson(),
        'error': error.toJson(),
      };
}
