import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF32373C),
  primarySwatch: MaterialColor(
    0xFF32373C,
    {
      50: Color(0xFFE3E4E5),
      100: Color(0xFFB8BABC),
      200: Color(0xFF8A8D91),
      300: Color(0xFF5C5F65),
      400: Color(0xFF3C4045),
      500: Color(0xFF32373C),
      600: Color(0xFF2C3035),
      700: Color(0xFF24282C),
      800: Color(0xFF1C2023),
      900: Color(0xFF121416),
    },
  ),
  accentColor: Color(0xFFF78DA7),
  backgroundColor: Color(0xFFF5F5F5),
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
      },
      builder: (context, child) {
        return ErrorBoundary(child: child!);
      },
    );
  }
}

class AppState extends ChangeNotifier {
  // Example state management logic
  String _data = "Hello, World!";
  String get data => _data;

  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appState.data),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              child: Text(AppLocalizations.of(context)!.detailsButton),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detailsTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.currentData(appState.data)),
            ElevatedButton(
              onPressed: () {
                appState.updateData("New Data from Details Screen");
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.updateDataButton),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorBoundary extends StatelessWidget {
  final Widget child;

  const ErrorBoundary({required this.child});

  @override
  Widget build(BuildContext context) {
    return ErrorWidget.builder = (FlutterErrorDetails details) {
      // Log error details
      print(details.toString());
      return Scaffold(
        body: Center(
          child: Text('Something went wrong!'),
        ),
      );
    };
  }
}
