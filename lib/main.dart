import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'config/theme/theme.dart';
import 'di/injector.dart';

const _flavor = Flavor.PROD;

void main() async {
  /// If you're running an application and need to access the binary messenger before `runApp()`
  /// has been called (for example, during plugin initialization), then you need to explicitly
  /// call the `WidgetsFlutterBinding.ensureInitialized()` first.
  /// If you're running a test, you can call the `TestWidgetsFlutterBinding.ensureInitialized()`
  /// as the first line in your test's `main()` method to initialize the binding.)
  WidgetsFlutterBinding.ensureInitialized();

  /// Forcing only portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  putLumberdashToWork(withClients: [ColorizeLumberdash()]);

  logMessage('Started Configuring dependencies');
  await AppInjector().configure(_flavor);
  logMessage("Finished Configuring dependencies");

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: MyApp(_flavor),
    ),
  );
}
