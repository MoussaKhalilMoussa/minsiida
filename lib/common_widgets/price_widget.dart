import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PriceWidget extends StatelessWidget {
  final String price;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const PriceWidget({
    super.key,
    required this.price,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Format the number as XAF currency, no decimals
    final formattedPrice = NumberFormat.currency(
      locale: 'fr_FR', // French formatting
      symbol: 'XAF', // Currency symbol
      decimalDigits: 0, // No decimals for XAF
    ).format(int.tryParse(price));
    return Text(
      formattedPrice,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        //fontFamily: "RobotoMono",
      ),
    );
  }
}
