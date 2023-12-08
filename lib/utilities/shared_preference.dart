import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _pref;

  Future<SharedPreferences?> instance() async {
    if (_pref != null) return _pref;
    await SharedPreferences.getInstance().then((onValue) {
      _pref = onValue;
    }).catchError((onError) {
      _pref = null;
    });
    return _pref;
  }

  static const String userName = "userName";
  static const String _accessToken = "accessToken";
  static const String _profileImage = "profileImage";
  static const String _userLogin = "userLogin";

  // remember me
  static const String rememberMe = "rememberMe";
  static const String userTypeIsCaster = "userTypeIsCaster";
  static const String userNameRememberMe = "userNameRemeber";
  static const String passwordRememberMe = "passwordRememberMe";

  static setUserName(String value) async {
    _pref?.setString(userName, value);
  }

  String getUserName() {
    return _pref?.getString(userName) ?? "";
  }

  static setRememberMe(bool value) async {
    _pref?.setBool(rememberMe, value);
  }

  static bool getRememberMe() {
    return _pref?.getBool(rememberMe) ?? false;
  }

  static setuserTypeIsCaster(bool value) async {
    _pref?.setBool(userTypeIsCaster, value);
  }

  static bool getuserTypeIsCaster() {
    return _pref?.getBool(userTypeIsCaster) ?? false;
  }

  static setUserNameRemeber(String value) async {
    _pref?.setString(userNameRememberMe, value);
  }

  String getUserNameRemember() {
    return _pref?.getString(userNameRememberMe) ?? "";
  }

  static setpasswordRememberMe(String value) async {
    _pref?.setString(passwordRememberMe, value);
  }

  String getpasswordRememberMe() {
    return _pref?.getString(passwordRememberMe) ?? "";
  }

  static setUserLogin(bool value) async {
    _pref?.setBool(_userLogin, value);
  }

  bool getUserLogin() {
    return _pref?.getBool(_userLogin) ?? false;
  }

  static setAccessToken(String value) async {
    _pref?.setString(_accessToken, value);
  }

  String getAccessToken() {
    return _pref?.getString(_accessToken) ?? "";
  }

  static setProfileImage(String value) async {
    _pref?.setString(_profileImage, value);
  }

  String getProfileImage() {
    return _pref?.getString(_profileImage) ?? "";
  }

  static removeShared(String val) {
    _pref?.remove(val);
  }

  clearSharedPreference() {
    _pref?.clear();
  }
}
