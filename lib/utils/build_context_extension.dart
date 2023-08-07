import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:flutter/widgets.dart';
import 'package:types_for_perception/beliefs.dart';

import '../app/state/app_state.dart';

extension BuildContextExtension on BuildContext {
  void land(LandingMission<AppState> mission) {
    return locate<MissionControl<AppState>>().land(mission);
  }

  Future<void> launch(AwayMission<AppState> mission) {
    return locate<MissionControl<AppState>>().launch(mission);
  }
}
