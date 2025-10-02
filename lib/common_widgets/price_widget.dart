import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PriceWidget extends StatelessWidget {
  final String price;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final bool compact; // Toggle compact mode

  const PriceWidget({
    super.key,
    required this.price,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.compact = false,
  });

  /// Format with k/m suffix and one optional decimal
  String formatCompact(num value, String locale) {
    final formatter = NumberFormat.decimalPattern(locale);

    String formatWithSuffix(double number, String suffix) {
      // keep 1 decimal if not round (e.g. 2,5k) otherwise just integer (2k)
      final str =
          number % 1 == 0
              ? formatter.format(number.toInt())
              : formatter.format(double.parse(number.toStringAsFixed(1)));
      return '$str$suffix XAF';
    }

    if (value >= 1000000) {
      return formatWithSuffix(value / 1000000, 'M');
    } else if (value >= 1000) {
      return formatWithSuffix(value / 1000, 'K');
    } else {
      return '${formatter.format(value)} XAF';
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = double.tryParse(price) ?? 0;
    const locale = 'fr_FR';

    final formattedPrice =
        compact
            ? formatCompact(value, locale)
            : NumberFormat.currency(
              locale: locale,
              symbol: 'XAF',
              decimalDigits: 0,
            ).format(value);

    return Text(
      formattedPrice,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
