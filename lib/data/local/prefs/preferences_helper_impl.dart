import 'package:shared_preferences/shared_preferences.dart';

import 'app_preference_helper.dart';
import 'package:meta/meta.dart';

class PreferencesHelperImpl implements AppPreferencesHelper {
  final SharedPreferences pref;

  static const String _PREF_USER_DATA = 'PREF_USER_DATA';
  static const _PREF_USER_LOGGED_IN = 'PREF_USER_LOGGED_IN';
  static const _PREF_USER_TOKEN = 'PREF_USER_TOKEN';

  PreferencesHelperImpl({@required this.pref});

  @override
  Future<bool> clear() async => await pref.clear();

  @override
  bool getUserLoggedIn() => pref.getBool(_PREF_USER_LOGGED_IN) ?? false;

  @override
  void setUserLoggedIn(bool isLoggedIn) =>
      pref.setBool(_PREF_USER_LOGGED_IN, isLoggedIn);

  @override
  String getUserToken() => pref.getString(_PREF_USER_TOKEN);

  @override
  void setUserToken(String token) => pref.setString(_PREF_USER_TOKEN, token);
}
