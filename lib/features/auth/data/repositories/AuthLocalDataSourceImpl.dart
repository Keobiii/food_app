import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences prefs;

  AuthLocalDatasourceImpl(this.prefs);

  static const String userIdKey = 'uid';

  @override
  Future<void> cachedUserId(String uid) async {
    await prefs.setString(userIdKey, uid);
  }

  @override
  Future<String?> getCachedUserId() async {
    return prefs.getString(userIdKey);
  }

  @override
  Future<void> clearUserId() async {
    await prefs.remove(userIdKey);
  }
}