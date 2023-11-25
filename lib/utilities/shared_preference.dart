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

  static const String _userName = "userName";
  static const String _accessToken = "accessToken";
  static const String _profileImage = "profileImage";
  static const String _userLogin = "userLogin";

  static setUserName(String value) async {
    _pref?.setString(_userName, value);
  }

  String getUserName() {
    return _pref?.getString(_userName) ?? "";
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



  clearSharedPreference() {
    _pref?.clear();
  }
}
