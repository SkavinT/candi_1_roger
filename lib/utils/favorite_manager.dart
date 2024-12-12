// favorite_manager.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:candi_1/models/candi.dart';

class FavoriteManager {
  static const String _favoriteKey = 'favoriteCandis';

  static Future<void> addFavorite(Candi candi) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList(_favoriteKey) ?? [];
    favoriteList.add(jsonEncode(candi.toJson()));
    await prefs.setStringList(_favoriteKey, favoriteList);
  }

  static Future<void> removeFavorite(Candi candi) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList(_favoriteKey) ?? [];
    favoriteList.removeWhere((item) => Candi.fromJson(jsonDecode(item)).name == candi.name);
    await prefs.setStringList(_favoriteKey, favoriteList);
  }

  static Future<List<Candi>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList(_favoriteKey) ?? [];
    return favoriteList.map((item) => Candi.fromJson(jsonDecode(item))).toList();
  }
}