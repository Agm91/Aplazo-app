import 'package:aplazo_app/di/locator.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';
import 'package:aplazo_app/l10n/app_localizations.dart';
import 'package:aplazo_app/screens/list_of_purchases_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/register_customer_screen.dart';
import 'screens/register_purchase_screen.dart';
import 'screens/success_screen.dart';

void main() {
  setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplazo App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      initialRoute: '/',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: RouteSettings(name: "/"),
            builder: (context) => RegisterCustomerScreen());
      case '/listOfPurchases':
        final args = settings.arguments as RegisterCustomerResponse;
        return MaterialPageRoute(
          settings: RouteSettings(name: "/listOfPurchases"),
          builder: (context) =>
              ListOfPurchasesScreen(registerCustomerResponse: args),
        );
      case '/purchase':
        final args = settings.arguments as RegisterCustomerResponse;
        return MaterialPageRoute(
          settings: RouteSettings(name: "/purchase"),
          builder: (context) =>
              RegisterPurchaseScreen(registerCustomerResponse: args),
        );
      case '/success':
        return MaterialPageRoute(
            settings: RouteSettings(name: "/purchase"),
            builder: (context) => SuccessScreen());
      default:
        return MaterialPageRoute(
            settings: RouteSettings(name: "/"),
            builder: (context) => RegisterCustomerScreen());
    }
  }
}
