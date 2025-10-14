import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String time;
  final bool isSeen;

  const OwnMessageCard({
    super.key,
    required this.message,
    required this.time,
    this.isSeen = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffdcf8c6),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 15.5,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isSeen ? Icons.done_all : Icons.done,
                  size: 18,
                  color: isSeen ? Colors.blueAccent : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
