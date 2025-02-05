import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:expenses_tracker_coursera/expenses.dart';
import 'package:expenses_tracker_coursera/providers/category_provider.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';
import 'package:expenses_tracker_coursera/providers/tag_provider.dart';
import 'package:expenses_tracker_coursera/screens/categories_sreeen.dart';
import 'package:expenses_tracker_coursera/screens/tags_screen.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(172, 53, 19, 247), brightness: Brightness.light);
final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 108, 87, 126), brightness: Brightness.dark);

final ThemeData darkThemeData =
    ThemeData().copyWith(colorScheme: darkColorScheme);
final ThemeData themeData = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.onPrimaryContainer,
      foregroundColor: lightColorScheme.onPrimary),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    bodyLarge:
        TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 20),
    bodyMedium:
        TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 18),
    bodySmall:
        TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 16),
    headlineSmall: TextStyle(color: Colors.white),
  ),
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(
    SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ExpenseProvider(storage: localStorage)),
          ChangeNotifierProvider(
              create: (context) => CategoryProvider(storage: localStorage)),
          ChangeNotifierProvider(
              create: (context) => TagProvider(storage: localStorage)),
        ],
        child: MaterialApp(
          theme: themeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.system,
          routes: {
            '/': (context) => const Expenses(),
            '/categories': (context) => const CategoriesSreeen(),
            '/tags': (context) => const TagsScreen(),
          },
        ),
      ),
    ),
  );
}
