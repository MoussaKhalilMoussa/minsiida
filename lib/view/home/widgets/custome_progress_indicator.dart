import 'package:flutter/material.dart';

class CustomeProgressIndicator extends StatelessWidget {
  const CustomeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(1), // spins infinitely
      child: Icon(
        Icons.autorenew,
        size: 40,
        color: Colors.blue,
      ),
    );
  }
}
