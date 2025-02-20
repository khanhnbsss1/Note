class StringFormatter {
  static String formatNumber(int? input) {
    // if (input.isEmpty) return '';

    // int? number = int.tryParse(input.replaceAll('.', '').replaceAll(',', ''));
    if (input == null) {
      return '0';
    }

    return input.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
    );
  }
}