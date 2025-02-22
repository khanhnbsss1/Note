import 'package:flutter/material.dart';
import 'package:note/config/app_config.dart';

class AppColor {
  // Primary Colors (Main Theme)
  final Color _primary = const Color(0xFFFFC924); // Amber (Warm, Creative Feel)
  final Color _primaryLight = const Color(0xFFFFEBB7);
  final Color _primaryDark = const Color(0xFFFFA000);

  // Background Colors
  final Color _backgroundLight = const Color(0xFFFFF8E1); // Soft Warm Background
  final Color _backgroundDark = const Color(0xFF303030); // Dark Mode

  // Text Colors
  final Color _textPrimary = Colors.black87;
  final Color _textSecondary = Colors.black54;
  final Color _textWhite = Colors.white;

  // Accent Colors (Used for Categorization or Highlights)
  final Color _accentBlue = const Color(0xFF64B5F6); // Soft Blue
  final Color _accentGreen = const Color(0xFF81C784); // Soft Green
  final Color _accentPink = const Color(0xFFF48FB1); // Soft Pink
  final Color _accentPurple = const Color(0xFFBA68C8); // Soft Purple
  final Color _accentOrange = const Color(0xFFFFB74D); // Soft Orange

  // Note Card Colors
  final Color _noteYellow = const Color(0xFFFFF176); // Light Yellow
  final Color _noteBlue = const Color(0xFF81D4FA); // Light Blue
  final Color _noteGreen = const Color(0xFFA5D6A7); // Light Green
  final Color _notePink = const Color(0xFFF8BBD0); // Light Pink
  final Color _notePurple = const Color(0xFFCE93D8); // Light Purple
  final Color _noteGrey = const Color(0xFFE0E0E0); // Neutral Grey

  // Black & White Shades
  final Color _black = Colors.black87;
  final Color _white = Colors.white;

  final Color _black87 = Colors.black87;
  final Color _black54 = Colors.black54;
  final Color _white70 = Colors.white70;

  Color get background {
    return AppConfigs().darkMode ? _black : _white;
  }

  Color get textColor {
    return AppConfigs().darkMode ? _textWhite : _textPrimary;
  }

  Color get iconColor {
    return AppConfigs().darkMode ? _textWhite : _textSecondary;
  }

  Color get primaryDark {
    return _primaryDark;
  }

  Color get primary {
    return _primary;
  }

  Color get accentBlue {
    return _accentBlue;
  }

  Color get accentGreen {
    return _accentGreen;
  }

  Color get accentPink {
    return _accentPink;
  }

  Color get primaryLight {
    return _primaryLight;
  }
}
