import 'package:dairy/config/locale.dart';
import 'package:dairy/config/theme.dart';
import 'package:dairy/data/model/movies.dart';
import 'package:dairy/data/remote/api_base_helper.dart';
import 'package:dairy/data/remote/api_client/api_response.dart';
import 'package:dairy/di/injector.dart';
import 'package:dairy/generated/i18n.dart';
import 'package:dairy/modules/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  final apiHelper = locator<ApiBaseHelper>();

  Future<void> fetchData() async {
    final data = await apiHelper.get(
      'popular?api_key=9c9576f8c2e86949a3220fcc32ae2fb6',
    );

    print('getOrDefault: ${data.getOrDefault(
      ApiResponse.unexpectedError(
        e: Exception('Default Sahil'),
      ),
    )}');

    data.getOrElse((error) {
      print('error type : ${error.runtimeType}');
      return error;
    });

    print('IsSuccess: ${data.isSuccess}');
    print('IsFailure: ${data.isFailure}');

    data.onSuccess((res) => print('OnSuccess : ${res.response.statusCode}'));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                    Locales.hindi,
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
