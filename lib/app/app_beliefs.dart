import 'package:perception/perception.dart';

class AppBeliefs
    implements
        CoreBeliefs,
        FramingConcept,
        ErrorCorrectionConcept,
        IdentityConcept {
  AppBeliefs({
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

  static AppBeliefs get initial => AppBeliefs(
        identity: DefaultIdentityBeliefs.initial,
        error: DefaultErrorCorrectionBeliefs.initial,
        framing: DefaultFramingBeliefs.initial,
      );

  @override
  AppBeliefs copyWith({
    DefaultFramingBeliefs? framing,
    DefaultErrorCorrectionBeliefs? error,
    IdentityBeliefs? identity,
  }) =>
      AppBeliefs(
        framing: framing ?? this.framing,
        identity: identity ?? this.identity,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'framing': framing.toJson(),
        'identity': identity.toJson(),
        'error': error.toJson(),
      };
}
