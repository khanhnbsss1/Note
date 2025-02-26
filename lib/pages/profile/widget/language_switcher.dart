
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  final String selectedLanguage; // Example: 'en' or 'vi'
  final Function(String) onLanguageChange;

  const LanguageSwitcher({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}


