import 'package:expenses_tracker_coursera/expenses.dart';
import 'package:expenses_tracker_coursera/providers/category_provider.dart';
import 'package:expenses_tracker_coursera/providers/expense_provider.dart';
import 'package:expenses_tracker_coursera/providers/tag_provider.dart';
import 'package:expenses_tracker_coursera/screens/categories_sreeen.dart';
import 'package:expenses_tracker_coursera/screens/tags_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 119, 46, 179), brightness: Brightness.light);
final ColorScheme darkColorScheme = ColorScheme.dark();

final ThemeData darkThemeData =
    ThemeData().copyWith(colorScheme: darkColorScheme);
final ThemeData themeData = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.onPrimaryContainer,
      foregroundColor: lightColorScheme.onPrimary),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge:
          TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 22),
      headlineSmall: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 18)),
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
          // Adicione outros providers aqui
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
