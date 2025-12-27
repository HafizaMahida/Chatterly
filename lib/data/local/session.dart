import 'dart:convert';
import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  static final UserLocalStorage _instance = UserLocalStorage._internal();

  factory UserLocalStorage() {
    return _instance;
  }

  UserLocalStorage._internal();

  static const _key = 'users';

  /// Save full user list
  Future<void> saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  /// Get all users
  Future<List<UserModel>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => UserModel.fromJson(e)).toList();
  }

  /// Add a new user
  Future<List<UserModel>> addUser(UserModel user) async {
    final users = await getUsers();
    users.add(user);
    await saveUsers(users);
    return users;
  }

  /// Clear storage (optional)
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

