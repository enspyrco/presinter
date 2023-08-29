import 'package:identity_in_perception/identity_in_perception.dart';
import 'package:test_utils_for_perception/test_utils_for_perception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presinter/home/home_screen.dart';
import 'package:presinter/home/role_selector.dart';
import 'package:presinter/home/sessions_view.dart';
import 'package:presinter/presinter_beliefs.dart';

void main() {
  testWidgets('HomeScreen should layout expected widgets', (tester) async {
    final testState = PresinterBeliefs.initial;

    final harness = WidgetTestHarness(
      initialState: testState,
      innerWidget: const HomeScreen(),
    );

    await tester.pumpWidget(harness.widget);

    final roleSelectorFinder = find.byType(RoleSelector);
    final sessionsViewFinder = find.byType(SessionsView);
    final accountButtonFinder = find.byType(AvatarMenuButton<PresinterBeliefs>);

    expect(roleSelectorFinder, findsOneWidget);
    expect(sessionsViewFinder, findsOneWidget);
    expect(accountButtonFinder, findsOneWidget);
  });
}
