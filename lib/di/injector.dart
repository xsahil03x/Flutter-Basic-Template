import 'package:dairy/data/local/prefs/app_preference_helper.dart';
import 'package:dairy/data/local/prefs/preferences_helper_impl.dart';
import 'package:dairy/data/remote/api_base_helper.dart';

import 'package:dairy/data/remote/converter/json_converter.dart';
import 'package:dairy/data/remote/interceptor/network_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

enum Flavor { PROD, DEBUG, MOCK }

const _prodBaseUrl = 'http://api.themoviedb.org/3/movie/';

const _debugBaseUrl = 'http://api.themoviedb.org/3/movie/';

class AppInjector {
  Flavor _flavor;

  static final AppInjector _singleton = AppInjector._internal();

  factory AppInjector() => _singleton;

  AppInjector._internal();

  Future<void> configure(Flavor flavor) async {
    this._flavor = flavor;
    await _initRepos();
  }

  Future<void> _initRepos() async {
    // DataBaseHelperAbstract
//    locator.registerSingleton<DatabaseHelperAbstract>(DatabaseHelper());

    // SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerLazySingleton<AppPreferencesHelper>(
        () => PreferencesHelperImpl(
              pref: sharedPreferences,
            ));

    // ApiBaseHelper
    locator.registerLazySingleton<ApiBaseHelper>(() {
      switch (_flavor) {
        case Flavor.PROD:
          return ProdApiNetwork(
            baseUrl: _prodBaseUrl,
            converter: JsonConverter(),
            interceptors: [NetworkInterceptor(prefHelper: locator())],
          );
        case Flavor.DEBUG:
          return DebugApiNetwork(_debugBaseUrl, JsonConverter());
        case Flavor.MOCK:
        default:
          return MockApiNetwork();
      }
    });
  }
}
