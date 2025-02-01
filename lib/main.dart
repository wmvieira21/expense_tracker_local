import 'package:expenses_tracker_coursera/expenses.dart';
import 'package:expenses_tracker_coursera/screens/add_expense.dart';
import 'package:expenses_tracker_coursera/screens/categories_sreeen.dart';
import 'package:expenses_tracker_coursera/screens/tags_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 119, 46, 179), brightness: Brightness.light);
final ColorScheme darkColorScheme = ColorScheme.dark();

final ThemeData themeData = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.onPrimaryContainer,
      foregroundColor: lightColorScheme.onPrimary),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge:
          TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 22),
      headlineSmall: TextStyle(color: Colors.white)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      backgroundColor:
          lightColorScheme.onPrimaryContainer.withValues(alpha: 50),
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 18),
    ),
  ),
);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    SafeArea(
      child: MaterialApp(
        theme: themeData,
        routes: {
          '/': (context) => const Expenses(),
          '/categories': (context) => const CategoriesSreeen(),
          '/tags': (context) => const TagsScreen(),
          '/newExpense': (context) => const AddExpense(),
        },
      ),
    ),
  );
}
