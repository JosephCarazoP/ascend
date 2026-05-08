import 'package:flutter/material.dart';

class AppTheme {
  static const Color accentGreen = Color(0xFF16A34A);
  static const Color accentGreenDark = Color(0xFF22C55E);

  static ThemeData get light {
    return _buildTheme(
      brightness: Brightness.light,
      background: Colors.white,
      foreground: Colors.black,
      muted: const Color(0xFFF5F5F5),
      border: const Color(0xFFE5E5E5),
      secondaryText: const Color(0xFF525252),
      accent: accentGreen,
    );
  }

  static ThemeData get dark {
    return _buildTheme(
      brightness: Brightness.dark,
      background: Colors.black,
      foreground: Colors.white,
      muted: const Color(0xFF0A0A0A),
      border: const Color(0xFF262626),
      secondaryText: const Color(0xFFA3A3A3),
      accent: accentGreenDark,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required Color muted,
    required Color border,
    required Color secondaryText,
    required Color accent,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: foreground,
      onPrimary: background,
      secondary: accent,
      onSecondary: Colors.white,
      error: foreground,
      onError: background,
      surface: background,
      onSurface: foreground,
    );

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: border)),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: background,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: border),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: muted,
        disabledColor: muted,
        selectedColor: accent.withValues(alpha: 0.14),
        secondarySelectedColor: accent.withValues(alpha: 0.14),
        labelStyle: TextStyle(color: foreground),
        secondaryLabelStyle: TextStyle(color: foreground),
        side: BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: DividerThemeData(color: border),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: accent, width: 1.4),
        ),
        errorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: foreground),
        ),
        focusedErrorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: foreground, width: 1.4),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: foreground,
          foregroundColor: background,
          disabledBackgroundColor: muted,
          disabledForegroundColor: secondaryText,
          minimumSize: const Size.fromHeight(44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: BorderSide(color: border),
          minimumSize: const Size.fromHeight(44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: foreground),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: foreground),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: foreground,
        textColor: foreground,
        subtitleTextStyle: TextStyle(color: secondaryText),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: accent),
    );
  }
}
