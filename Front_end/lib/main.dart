import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'l10n/app_localizations.dart';
import 'screens/welcome_screen.dart';
import 'screens/context_screen.dart';
import 'screens/architecture_screen.dart';
import 'screens/results_screen.dart';
import 'screens/dashboard_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(const CartoVecApp());
}

class CartoVecApp extends StatefulWidget {
  const CartoVecApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _CartoVecAppState? state = context.findAncestorStateOfType<_CartoVecAppState>();
    state?.setLocale(locale);
  }

  @override
  State<CartoVecApp> createState() => _CartoVecAppState();
}

class _CartoVecAppState extends State<CartoVecApp> {
  Locale _locale = const Locale('fr');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CartoVec - PFA',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('ar'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('fr');
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0d6b78),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: _locale.languageCode == 'ar'
            ? GoogleFonts.cairoTextTheme()
            : GoogleFonts.interTextTheme(),
        fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  bool _showWelcome = true;

  final List<Widget> _screens = [
    const ContextScreen(),
    const ArchitectureScreen(),
    const ResultsScreen(),
    const DashboardScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
      _showWelcome = false;
    });
  }

  void _onGetStarted() {
    setState(() {
      _showWelcome = false;
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showWelcome) {
      return WelcomeScreen(onGetStarted: _onGetStarted);
    }

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
