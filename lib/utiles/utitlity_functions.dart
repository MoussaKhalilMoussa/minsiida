String truncateWithEllipsis(String s, {int cutoff = 30}) {
  if (s.length <= cutoff) return s;
  return '${s.substring(0, 20)}...';
}

String shortTruncateWithEllipsis(String s, {int cutoff = 20}) {
  if (s.length <= cutoff) return s;
  return '${s.substring(0, 15)}...';
}

String extractMonthYear(String isoString) {
  try {
    final date = DateTime.parse(isoString);
    final now = DateTime.now();

    final year = date.year;
    final month = date.month;

    // French month names
    final monthName =
        [
          "janvier",
          "février",
          "mars",
          "avril",
          "mai",
          "juin",
          "juillet",
          "août",
          "septembre",
          "octobre",
          "novembre",
          "décembre",
        ][month - 1];

    // If same year → return "monthName year"
    // Otherwise → return "year"
    return (year == now.year) ? "$monthName $year" : "$year";
  } catch (e) {
    return "Invalid date";
  }
}


String formatShortDate(String isoString) {
  try {
    final date = DateTime.parse(isoString);

    // Short month names in English
    final months = [
      "jan", "feb", "mar", "apr", "may", "jun",
      "jul", "aug", "sep", "oct", "nov", "dec"
    ];

    final month = months[date.month - 1];
    final day = date.day.toString().padLeft(2, '0'); // always 2 digits
    final year = date.year;

    return "$month $day $year";
  } catch (e) {
    return "Invalid date";
  }
}
