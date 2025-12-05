import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/about_screen.dart';

void main() {
  group('AppDrawer Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    Widget createTestApp() {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Test')),
          drawer: const AppDrawer(),
          body: const Center(child: Text('Home Screen')),
        ),
        routes: {
          '/': (context) => OrderScreen(cart: cart),
          '/cart': (context) => CartScreen(cart: cart),
          '/profile': (context) => const ProfileScreen(),
          '/about': (context) => const AboutScreen(),
        },
      );
    }

    testWidgets('displays drawer icon in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('opens drawer when icon is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Sandwich Shop'), findsOneWidget);
      expect(find.text('Order'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('My Profile'), findsOneWidget);
      expect(find.text('About Us'), findsOneWidget);
    });

    testWidgets('displays all navigation options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_bag), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('closes drawer when navigation item is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.text('My Profile'));
      await tester.pumpAndSettle();

      expect(find.text('Sandwich Shop'), findsNothing);
      expect(find.text('My Profile'), findsOneWidget); // AppBar title
    });

    testWidgets('navigates to Profile screen when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.text('My Profile'));
      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
    });

    testWidgets('navigates to About screen when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.text('About Us'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome to Sandwich Shop!'), findsOneWidget);
    });

    testWidgets('drawer header displays logo and title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.byType(DrawerHeader), findsOneWidget);
      expect(find.text('Sandwich Shop'), findsOneWidget);
    });

    testWidgets('displays divider before exit option', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
