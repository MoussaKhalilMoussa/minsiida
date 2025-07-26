import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/p1.jpeg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Iphone 14 Pro Max',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '\$899.99',
                          style: GoogleFonts.playfairDisplay(
                            color: blackColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            'Active',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.eye_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '123 views',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Ionicons.calendar_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '2025-01-01',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.eye_outline, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      'View',
                      style: GoogleFonts.playfairDisplay(color: Colors.blue),
                    ),
                  ],
                ),
                onPressed: () {
                  // Edit action
                },
              ),
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.create_outline, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      'Edit',
                      style: GoogleFonts.playfairDisplay(color: Colors.green),
                    ),
                  ],
                ),
                onPressed: () {
                  // Delete action
                },
              ),
              IconButton(
                icon: Row(
                  children: [
                    Icon(Ionicons.trash_outline, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      'Delete',
                      style: GoogleFonts.playfairDisplay(color: Colors.red),
                    ),
                  ],
                ),
                onPressed: () {
                  // Delete action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
