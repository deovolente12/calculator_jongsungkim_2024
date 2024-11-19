import 'package:shared_preferences/shared_preferences.dart';

class SimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyCalculationHistory = 'calculation_history';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> addToCalculationHistory(String calculation, String result) async {
    if (_preferences == null) return;
    List<String> history = _preferences?.getStringList(_keyCalculationHistory) ?? [];
    history.add('$calculation = $result');
    await _preferences?.setStringList(_keyCalculationHistory, history);
  }

  static List<String> getCalculationHistory() {
    if (_preferences == null) return [];
    return _preferences?.getStringList(_keyCalculationHistory) ?? [];
  }

  static Future<void> clearCalculationHistory() async {
    if (_preferences == null) return;
    await _preferences?.remove(_keyCalculationHistory);
  }
}