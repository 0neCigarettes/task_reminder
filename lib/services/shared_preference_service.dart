import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<void> clearStorage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      debugPrint('[clearStorage] Success clear');
    } catch (e) {
      debugPrint('[clearStorage] Error Occurred $e');
    }
  }

  Future<void> setBool(String? key, bool? value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key!, value!);
      debugPrint('[setBool] Success SetBoll');
    } catch (e) {
      debugPrint('[setBool] Error Occurred $e');
    }
  }

  Future<bool?> getBool(String? key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.getBool(key!);

      return data;
    } catch (e) {
      debugPrint('[getBool] Error Occurred $e');
      return null;
    }
  }
}
