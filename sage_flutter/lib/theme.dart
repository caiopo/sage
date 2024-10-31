import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.openSansTextTheme(baseTextTheme);
  TextTheme displayTextTheme = GoogleFonts.maliTextTheme(baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

ThemeData createTheme(BuildContext context, Brightness brightness) {
  final theme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFDA5C47),
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      brightness: brightness,
    ),
    textTheme: createTextTheme(context),
    useMaterial3: true,
  );

  final largerButtonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(96, 48)),
  );

  return theme.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    filledButtonTheme: FilledButtonThemeData(style: largerButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: largerButtonStyle),
  );
}
