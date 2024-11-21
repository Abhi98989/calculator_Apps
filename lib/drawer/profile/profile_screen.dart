import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Profile Image and Name
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/logos/cal1.png'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle change profile image
                    },
                    child: const Text('Change Profile Image'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile Details Section
              _buildSectionHeader('Profile Details'),
              _buildProfileMenu('Name', 'Abhi Chaudhary'),
              _buildProfileMenu('Username', 'abhi11221@gmail.com'),

              const SizedBox(height: 20),

              // Additional Details Section
              _buildSectionHeader('Additional Details'),
              _buildProfileMenu('User ID', '11221'),
              _buildProfileMenu('Email', 'abhi11221@gmail.com'),
              _buildProfileMenu('Phone Number', '+91 9876543210'),
              _buildProfileMenu('Gender', 'Male'),
              _buildProfileMenu('Date of Birth', '1990-05-15'),
              _buildProfileMenu('Date of Registration', '2022-01-01'),
              _buildProfileMenu('Last Login', '2022-02-15 12:30:45'),
              _buildProfileMenu('Address', '123 Main St, Anytown, USA'),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for building section headers
  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Helper function for building profile menu items
  Widget _buildProfileMenu(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
