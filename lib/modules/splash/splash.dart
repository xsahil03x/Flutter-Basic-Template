import 'package:flutter/material.dart';
import 'package:flutter_template/config/locale.dart';
import 'package:flutter_template/config/theme/theme.dart';
import 'package:flutter_template/generated/i18n.dart';
import 'package:flutter_template/modules/base/base_state.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(I18n.of(context).home),
              RaisedButton(
                child: Text('Change'),
                onPressed: () {
                  I18n.onLocaleChanged(
                    Locales.HINDI,
                  );
                  Provider.of<ThemeModel>(context).toggleTheme();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
