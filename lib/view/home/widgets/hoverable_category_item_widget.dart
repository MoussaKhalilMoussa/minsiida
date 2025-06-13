import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class HoverableCategoryItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const HoverableCategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<HoverableCategoryItem> createState() => _HoverableCategoryItemState();
}

class _HoverableCategoryItemState extends State<HoverableCategoryItem> {
  bool _isClicked = false;

  void _handleTap() async {
    setState(() => _isClicked = true);
    await Future.delayed(const Duration(milliseconds: 200)); // Brief highlight
    widget.onTap(); // Trigger navigation or logic
    if (mounted) {
      setState(() => _isClicked = false); // Reset highlight (optional if routing replaces the screen)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: _isClicked ? blueColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: widget.color,
              child: Icon(
                widget.icon,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              overflow: TextOverflow.clip,
              style: GoogleFonts.playfairDisplay(
                fontSize: 11,
                color: greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
