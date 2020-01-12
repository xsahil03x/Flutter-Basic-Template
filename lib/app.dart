import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/locale.dart';
import 'config/theme/theme.dart';
import 'di/injector.dart';
import 'generated/i18n.dart';
import 'routes/app_routes.dart';

class MyApp extends StatefulWidget {
  final Flavor _flavor;

  const MyApp(this._flavor);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final i18n = I18n.delegate;

  @override
  void initState() {
    super.initState();
    I18n.onLocaleChanged = (Locale locale) {
      setState(() => I18n.locale = locale);
    };
  }

  String get _title {
    switch (widget._flavor) {
      case Flavor.DEBUG:
        return '- Dev';
      case Flavor.MOCK:
        return '- Mock';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hurray $_title',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      localizationsDelegates: [i18n],
      onGenerateRoute: AppRoutes.generateRoute,
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(
        fallback: Locales.ENGLISH,
      ),
    );
  }
}
