import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart'; // Import to use SystemNavigator

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Calculator App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.people),
          //   title: const Text('Profile'),
          //   onTap: () {
          //     context.go('/ProfileScreen'); // Navigate to profile screen
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.history),
          //   title: const Text('History'),
          //   onTap: () {
          //     context.go('/StorageScreen'); // Navigate to history screen
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Mode'),
            onTap: () {
              context.go('/ModeScreen'); // Navigate to mode screen
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('About Us'),
          //   onTap: () {
          //     context.go('/AboutUsPageScreen'); // Navigate to about us page
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('Privacy Policy'),
          //   onTap: () {
          //     context.go('/PrivacyPolicyScreen'); // Navigate to about us page
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              SystemNavigator.pop(); // Close the app
            },
          ),
        ],
      ),
    );
  }
}
