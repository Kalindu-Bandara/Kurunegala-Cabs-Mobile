import 'dart:math' as math;
import 'package:flutter/material.dart';

class RedSquare extends StatelessWidget {
  final double size;
  final double top;
  final double right;
  final double bottom;
  final double left;
  final double blurRadius; // Added for customizable blur radius
  final double spreadRadius; // Added for customizable spread radius

  const RedSquare({
    Key? key,
    required this.size,
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
    this.blurRadius = 15.0, // Default value
    this.spreadRadius = 3.0, // Default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFFF0000), // Pure red color for squares
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: const Offset(5, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
