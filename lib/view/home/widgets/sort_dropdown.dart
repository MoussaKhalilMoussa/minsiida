import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class SortDropdown extends StatefulWidget {
  const SortDropdown({super.key});

  @override
  _SortDropdownState createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String _selectedValue = 'Trier par';
  final List<String> _options = [
    'Trier par',
    'Prix croissant',
    'Prix décroissant',
    'Plus récents',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: _selectedValue,
        customButton: Container(
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            color: greyColo1.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(60),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedValue,
                style: GoogleFonts.playfairDisplay(fontSize: 14),
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
                    child: Text(item, overflow: TextOverflow.ellipsis),
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
