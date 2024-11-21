import 'package:flutter/material.dart';

class AboutUsPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'About the Calculator App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to our Calculator App, an innovative tool designed to simplify your everyday mathematical tasks. '
                'Whether you’re performing basic arithmetic or solving complex calculations, this app provides a seamless and reliable experience.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                'Developed by Abhishek Chaudhary, a passionate BSCIT student and aspiring software developer, this calculator app '
                'is a perfect blend of academic learning and practical application. It emphasizes user-friendly design, efficient operation, and robust logic.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),
              Text(
                'Key Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              BulletPoint(text: 'Efficient and accurate calculation logic.'),
              BulletPoint(text: 'Real-time operation display (e.g., 2 + 2 = 4).'),
              BulletPoint(text: 'Light and dark mode for customizable themes.'),
              BulletPoint(text: 'Handles edge cases like division by zero gracefully.'),
              BulletPoint(text: 'Intuitive design for smooth and seamless user interaction.'),
              SizedBox(height: 24),
              Text(
                'Developer Vision:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'The calculator app is crafted with a vision to make mathematical operations simple, efficient, and accessible for everyone. '
                'We aim to continually enhance its features and design to ensure it meets the diverse needs of its users.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),
              Text(
                'Developer Profile:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Connect with Abhishek Chaudhary to explore more innovative projects and learn about modern app development practices:',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 8),
              Text(
                'GitHub Profile: https://github.com/Abhi98989/calculator_Apps.git',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'LinkedIn Profile: https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }
}
