import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:abstractions/beliefs.dart';

import '../presinter_beliefs.dart';

extension BuildContextExtension on BuildContext {
  void land(Conclusion<PresinterBeliefs> mission) {
    return locate<BeliefSystem<PresinterBeliefs>>().conclude(mission);
  }

  Future<void> launch(Consideration<PresinterBeliefs> mission) {
    return locate<BeliefSystem<PresinterBeliefs>>().consider(mission);
  }
}
