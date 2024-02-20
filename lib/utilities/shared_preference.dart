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
  static const String userId = "userId";
  static const String _accessToken = "accessToken";
  static const String _profileImage = "profileImage";
  static const String _userLogin = "userLogin";
  static const String _userType = "userType";
  static const String _boosterCount = "boosterCount";


  static setUserName(String value) async {
    _pref?.setString(userName, value);
  }
  String getUserName() {
    return _pref?.getString(userName) ?? "";
  }

  static setUserId(int value) async {
    _pref?.setInt(userId, value);
  }
  int getUserId() {
    return _pref?.getInt(userId) ?? 0;
  }


  static setBoosterCount(int value) async {
    _pref?.setInt(_boosterCount, value);
  }
  int getBoosterCount() {
    return _pref?.getInt(_boosterCount) ?? 0;
  }




  static setUserLogin(bool value) async {
    _pref?.setBool(_userLogin, value);
  }

  bool getUserLogin() {
    return _pref?.getBool(_userLogin) ?? false;
  }

  //user type 1 for talent
  //user type 2 for caster
  static setUserType(int value) async {
    _pref?.setInt(_userType, value);
  }

  int getUserType() {
    return _pref?.getInt(_userType) ?? 0;
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
