import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';

import 'config/themes/app_themes.dart';
import 'core/utils/app_strings.dart';
import 'features/presentation/screens/quote_screen.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const QuoteScreen(),
    );
  }
}