import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:abstractions/beliefs.dart';

import '../app/app_beliefs.dart';

extension BuildContextExtension on BuildContext {
  void land(Conclusion<AppBeliefs> mission) {
    return locate<BeliefSystem<AppBeliefs>>().conclude(mission);
  }

  Future<void> launch(Consideration<AppBeliefs> mission) {
    return locate<BeliefSystem<AppBeliefs>>().consider(mission);
  }
}
