import 'dart:convert';
import 'package:maharashtra_board_books/data/models/SubjectsApiResModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  SharedPreferences? _preferences;

  saveUserDetails(model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserDetails', jsonEncode(model));
  }

  Future<Subjects> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> jsonData = jsonDecode(prefs.getString('UserDetails')!);
    return Subjects.fromJson(jsonData);
  }


  void saveUserId(String userId) async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.setString("UserId", userId);
  }

  Future<String?> getUserId() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences!.containsKey("UserId")) {
      String? key = _preferences!.getString("UserId");
      return key;
    }
    else {
      return "";
    }
  }


  void clearPreferenceData() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.clear();
  }
}