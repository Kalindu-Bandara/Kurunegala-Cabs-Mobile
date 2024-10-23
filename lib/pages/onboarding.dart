import 'package:flutter/material.dart';
import 'package:sofrwere_project/Admin/admin_login.dart';
import 'package:sofrwere_project/pages/signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Geometric Shapes
          Container(
            color: const Color(0xfff2f2f2), // Light grey background
            child: Stack(
              children: [
                // Rotated Squares
                Positioned(
                  top: -50,
                  left: -40,
                  child: Transform.rotate(
                    angle: 0.4,
                    child: Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFFFF0000), // Pure Red
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 100,
                  child: Transform.rotate(
                    angle: 0.3,
                    child: Container(
                      width: 120,
                      height: 120,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 100,
                  child: Transform.rotate(
                    angle: 0.2,
                    child: Container(
                      width: 160,
                      height: 160,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
                // Additional Rotated Squares
                Positioned(
                  top: 250,
                  left: 30,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  right: 150,
                  child: Transform.rotate(
                    angle: 0.6,
                    child: Container(
                      width: 140,
                      height: 140,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 50,
                  child: Transform.rotate(
                    angle: 0.7,
                    child: Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 300,
                  left: 100,
                  child: Transform.rotate(
                    angle: 0.1,
                    child: Container(
                      width: 120,
                      height: 120,
                      color: const Color(0xFFFF0000),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main Content of the Onboarding Screen
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/onboarding.png'), // Onboarding image
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                      ),
                    ),
                    // Overlay with Gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6), // Darker gradient fade
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Slightly transparent white background
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Kurunagala Cabs.\nExperience Luxury Travel!',
                        style: TextStyle(
                          color: Color(0xFFB71C1C), // Deep Crimson
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      const Text(
                        'Premium car rentals tailored for you.\nDiscover elegance at an unbeatable price.',
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Get Started Button
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5722), // Vibrant Orange
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Navigate to the next screen (Home page)
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AdminLogin()),
                            );
                          },
                          child: const Text(
                            'Let\'s Go!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Example HomePage class (you can replace this with your actual HomePage implementation)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to Kurunagala Cabs!'),
      ),
    );
  }
}
