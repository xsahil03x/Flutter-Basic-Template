import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:dairy/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'di/injector.dart';

const _flavor = Flavor.PROD;

void main() async {
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
