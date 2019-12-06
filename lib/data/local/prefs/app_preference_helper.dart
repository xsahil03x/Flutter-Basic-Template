abstract class AppPreferencesHelper{

  Future<bool> clear();

  void setUserToken(String token);
  String getUserToken();

  void setUserLoggedIn(bool isLoggedIn);
  bool getUserLoggedIn();

}