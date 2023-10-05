import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:abstractions/identity.dart';
import 'package:abstractions/beliefs.dart';
import 'package:abstractions/error_correction.dart';
import 'package:abstractions/framing.dart';
import 'package:percepts/percepts.dart';

class PresinterBeliefs
    implements
        CoreBeliefs,
        FramingConcept,
        ErrorCorrectionConcept,
        IdentityConcept {
  PresinterBeliefs({
    required this.identity,
    required this.error,
    required this.framing,
  });

  @override
  final IdentityBeliefs identity;
  @override
  final DefaultErrorCorrectionBeliefs error;
  @override
  final DefaultFramingBeliefs framing;

  static PresinterBeliefs get initial => PresinterBeliefs(
        identity: DefaultIdentityBeliefs.initial,
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
        identity: auth ?? this.identity,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'framing': framing.toJson(),
        'identity': identity.toJson(),
        'error': error.toJson(),
      };
}
