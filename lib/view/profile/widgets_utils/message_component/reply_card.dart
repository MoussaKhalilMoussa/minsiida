import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyCard extends StatelessWidget {
  final String message;
  final String time;

  const ReplyCard({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha:0.15),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: IntrinsicWidth( //allows the container to shrink to text width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // prevents extra space vertically
            children: [
              Flexible(
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 15.5,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
