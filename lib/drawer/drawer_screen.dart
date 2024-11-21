import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[600],
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              context.pop(); // Use pop method from GoRouter
              context.push('/ProfileScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Storage'),
            onTap: () {
              context.pop(); // Use pop method from GoRouter
              context.push('/StorageScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              context.pop(); // Use pop method from GoRouter
              context.push('/AboutUsPageScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () {
              context.pop(); // Use pop method from GoRouter
              context.push('/PrivacyPolicyScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              context.pop(); // Use pop method from GoRouter
              context.push('/SettingsScreen');
            },
          ),
        ],
      ),
    );
  }
}
