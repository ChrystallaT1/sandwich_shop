import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  group('ProfileScreen Tests', () {
    Future<void> pumpProfileScreen(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    }

    testWidgets('displays app bar with My Profile title', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.text('My Profile'), findsOneWidget);
    });

    testWidgets('displays user avatar with person icon', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.backgroundColor, Colors.teal);
      expect(avatar.radius, 60);
    });

    testWidgets('displays user name and email', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
    });

    testWidgets('displays Account Information section', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.text('Account Information'), findsOneWidget);
    });

    testWidgets('displays phone number with icon', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      expect(find.text('Phone'), findsOneWidget);
      expect(find.text('+44 123 456 7890'), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('displays delivery address with icon', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.text('Address'), findsOneWidget);
      expect(find.text('123 Main Street, London, UK'), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('displays Preferences section', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      expect(find.text('Preferences'), findsOneWidget);
    });

    testWidgets('displays favorite sandwich with heart icon', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.text('Favorite Sandwich'), findsOneWidget);
      expect(find.text('Veggie Delight on White Bread'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('displays notification status with icon', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Enabled'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('displays dividers between list items', (
      WidgetTester tester,
    ) async {
      await pumpProfileScreen(tester);

      expect(find.byType(Divider), findsNWidgets(3));
    });

    testWidgets('displays all list tiles', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      expect(find.byType(ListTile), findsNWidgets(4));
    });

    testWidgets('screen is scrollable', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('icons have correct colors', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      final phoneIcon = tester.widget<Icon>(
        find.descendant(
          of: find.ancestor(
            of: find.text('Phone'),
            matching: find.byType(ListTile),
          ),
          matching: find.byIcon(Icons.phone),
        ),
      );
      expect(phoneIcon.color, Colors.teal);

      final locationIcon = tester.widget<Icon>(
        find.descendant(
          of: find.ancestor(
            of: find.text('Address'),
            matching: find.byType(ListTile),
          ),
          matching: find.byIcon(Icons.location_on),
        ),
      );
      expect(locationIcon.color, Colors.teal);

      final favoriteIcon = tester.widget<Icon>(
        find.descendant(
          of: find.ancestor(
            of: find.text('Favorite Sandwich'),
            matching: find.byType(ListTile),
          ),
          matching: find.byIcon(Icons.favorite),
        ),
      );
      expect(favoriteIcon.color, Colors.red);

      final notificationIcon = tester.widget<Icon>(
        find.descendant(
          of: find.ancestor(
            of: find.text('Notifications'),
            matching: find.byType(ListTile),
          ),
          matching: find.byIcon(Icons.notifications),
        ),
      );
      expect(notificationIcon.color, Colors.orange);
    });

    testWidgets('content has proper padding', (WidgetTester tester) async {
      await pumpProfileScreen(tester);

      final padding = tester.widget<Padding>(
        find
            .descendant(
              of: find.byType(SingleChildScrollView),
              matching: find.byType(Padding),
            )
            .first,
      );

      expect(padding.padding, const EdgeInsets.all(16.0));
    });
  });
}
