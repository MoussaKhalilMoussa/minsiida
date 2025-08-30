import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class Selectionbutton extends StatefulWidget {
  const Selectionbutton({super.key});

  @override
  _SelectionbuttonState createState() => _SelectionbuttonState();
}

class _SelectionbuttonState extends State<Selectionbutton> {
  String _selectedValue = 'Sélectionnez une catégorie';
  final List<String> _options = [
    'Sélectionnez une catégorie',
    'Problèmes de compte',
    'Processus d\'achat',
    'Processus de vente',
    'Problèmes de paiement',
    'Problèmes d\'expédition',
    'Problèmes techniques',
    'Autre',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: _selectedValue,
        customButton: Container(
          width: double.maxFinite,
          height: 45.h,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyColor.withValues(alpha: 0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedValue,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: blackColor2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const Icon(LucideIcons.chevronDown, size: 20),
            ],
          ),
        ),
        //dropdownDirection: DropdownDirection.right, // Can be up, down, left, right
        items:
            _options
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackColor2,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            _selectedValue = value!;
          });
        },

        dropdownStyleData: DropdownStyleData(
          elevation: 2,

          decoration: BoxDecoration(
            color: greyColo1.withValues(alpha: 5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
