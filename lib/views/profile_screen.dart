import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile', style: heading1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text('John Doe', style: heading2),
              const SizedBox(height: 10),
              const Text('john.doe@example.com', style: normalText),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Account Information', style: heading2),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.phone, color: Colors.teal),
                title: Text('Phone', style: normalText),
                subtitle: Text('+44 123 456 7890'),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.location_on, color: Colors.teal),
                title: Text('Address', style: normalText),
                subtitle: Text('123 Main Street, London, UK'),
              ),
              const Divider(),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Preferences', style: heading2),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text('Favorite Sandwich', style: normalText),
                subtitle: Text('Veggie Delight on White Bread'),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.notifications, color: Colors.orange),
                title: Text('Notifications', style: normalText),
                subtitle: Text('Enabled'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
