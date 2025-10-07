import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key, required this.text, required this.padding});
  final String text;
  final EdgeInsetsGeometry padding;

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
