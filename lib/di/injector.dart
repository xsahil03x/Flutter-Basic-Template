import 'package:flutter_template/data/item_repository.dart';
import 'package:flutter_template/data/local/prefs/app_preference_helper.dart';
import 'package:flutter_template/data/local/prefs/preferences_helper_impl.dart';
import 'package:flutter_template/data/remote/api_base_helper.dart';
import 'package:flutter_template/data/repo/item_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_template/data/local/db/database_helper.dart';
import 'package:flutter_template/data/local/db/database_helper_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

enum Flavor { PROD, DEBUG, MOCK }

const _prodBaseUrl = 'INSERT PROD BASE URL HERE';

const _debugBaseUrl = 'INSERT DEBUG BASE URL HERE';

const String _databaseName = 'Main.db';

const int _databaseVersion = 1;

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
    // SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerLazySingleton<AppPreferencesHelper>(
        () => PreferencesHelperImpl(
              pref: sharedPreferences,
            ));

    // DataBaseHelper
    locator.registerSingleton<DatabaseHelper>(
      DatabaseHelperImpl(
        databaseName: _databaseName,
        databaseVersion: _databaseVersion,
      )..init(),
    );

    // ApiBaseHelper
    locator.registerLazySingleton<ApiBaseHelper>(() {
      switch (_flavor) {
        case Flavor.PROD:
          return ProdApiNetwork(baseUrl: _prodBaseUrl);
        case Flavor.DEBUG:
          return DebugApiNetwork(baseUrl: _debugBaseUrl);
        case Flavor.MOCK:
        default:
          return MockApiNetwork();
      }
    });

    // ItemRepository
    locator.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(
        helper: locator(),
      ),
    );
  }
}
