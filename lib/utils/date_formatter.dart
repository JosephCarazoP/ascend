String formatShortDate(DateTime? date) {
  if (date == null) {
    return 'Sin fecha';
  }

  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');

  return '$day/$month/${date.year}';
}
