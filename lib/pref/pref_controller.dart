import 'package:rev/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { loggedIn, id, email, fullName, gender, token }

class SharedPrefController {
  SharedPrefController._();

  static final SharedPrefController _instance = SharedPrefController._();

  factory SharedPrefController() {
    return _instance;
  }

  late SharedPreferences _sharedPreferences;

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(Student student) async {
    await _sharedPreferences.setBool(PrefKey.loggedIn.toString(), true);
    await _sharedPreferences.setInt(PrefKey.id.toString(), student.id);
    await _sharedPreferences.setString(PrefKey.email.toString(), student.email);
    await _sharedPreferences.setString(
        PrefKey.fullName.toString(), student.fullName);
    await _sharedPreferences.setString(
        PrefKey.gender.toString(), student.gender);
    await _sharedPreferences.setString(
        PrefKey.token.toString(), 'Bearer ${student.token}');
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKey.loggedIn.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKey.token.toString()) ?? '';

  Future<void> clear() async => await _sharedPreferences.clear();
}
