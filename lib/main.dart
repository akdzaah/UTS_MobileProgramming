
import 'package:flutter/material.dart';
import 'pages/country_list_page.dart';

void main() {
  runApp(const InformasiNegaraApp());
}

class InformasiNegaraApp extends StatelessWidget {
  const InformasiNegaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navyBlue = Color(0xFF163A70);
    const primaryBlue = Color(0xFF3478F6);
    const backgroundColor = Color(0xFFF2F7FF);
    const textColor = Color(0xFF263445);

    return MaterialApp(
      title: 'Informasi Negara',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: navyBlue,
          surface: Colors.white,
        ),

        scaffoldBackgroundColor: backgroundColor,

        appBarTheme: const AppBarTheme(
          backgroundColor: navyBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: navyBlue.withValues(alpha: 0.08),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: navyBlue,
          ),
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: navyBlue,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF8A96A8),
            fontSize: 15,
          ),
          prefixIconColor: primaryBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE0E9F5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 1.5,
            ),
          ),
        ),

        listTileTheme: const ListTileThemeData(
          iconColor: primaryBlue,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),

        dividerTheme: const DividerThemeData(
          color: Color(0xFFE5ECF5),
          thickness: 1,
        ),
      ),

      home: const CountryListPage(),
    );
  }
}
