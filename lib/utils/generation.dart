import 'package:shared_preferences/shared_preferences.dart';

Future<int> getSavedCurrentGeneration() async {
  final prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(seconds: 1));
  return prefs.getInt('GENERATION') ?? 5;
}

Future<void> saveCurrentGeneration(int currentGeneration) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('GENERATION', currentGeneration);
}
