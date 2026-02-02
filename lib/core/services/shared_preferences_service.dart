import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  SharedPreferencesService._();

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Login status
  Future<bool> get isLoggedIn async {
    return _preferences?.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _preferences?.setBool(AppConstants.isLoggedInKey, value);
  }

  // User ID
  Future<String?> get userId async {
    return _preferences?.getString(AppConstants.userIdKey);
  }

  Future<void> setUserId(String userId) async {
    await _preferences?.setString(AppConstants.userIdKey, userId);
  }

  // User Email
  Future<String?> get userEmail async {
    return _preferences?.getString(AppConstants.userEmailKey);
  }

  Future<void> setUserEmail(String email) async {
    await _preferences?.setString(AppConstants.userEmailKey, email);
  }

  // User Name
  Future<String?> get userName async {
    return _preferences?.getString(AppConstants.userNameKey);
  }

  Future<void> setUserName(String name) async {
    await _preferences?.setString(AppConstants.userNameKey, name);
  }

  // Auth Token
  Future<String?> get authToken async {
    return _preferences?.getString(AppConstants.authTokenKey);
  }

  Future<void> setAuthToken(String token) async {
    await _preferences?.setString(AppConstants.authTokenKey, token);
  }

  // Auth Role
  Future<String?> get getSavedRole async {
    return _preferences?.getString(AppConstants.authRoleKey);
  }

  Future<void> setSaveRole(String role) async {
    await _preferences?.setString(AppConstants.authRoleKey, role);
  }

  // User First Name
  Future<String?> get userFirstName async {
    return _preferences?.getString(AppConstants.userFirstNameKey);
  }

  Future<void> setUserFirstName(String firstName) async {
    await _preferences?.setString(AppConstants.userFirstNameKey, firstName);
  }

  // User Last Name
  Future<String?> get userLastName async {
    return _preferences?.getString(AppConstants.userLastNameKey);
  }

  Future<void> setUserLastName(String lastName) async {
    await _preferences?.setString(AppConstants.userLastNameKey, lastName);
  }
  // User Mobile
  Future<String?> get userMobile async {
    return _preferences?.getString(AppConstants.userMobileKey);
  }

  Future<void> setUserMobile(String mobile) async {
    await _preferences?.setString(AppConstants.userMobileKey, mobile);
  }

  // User Profile Image
  Future<String?> get userProfileImage async {
    return _preferences?.getString(AppConstants.userProfileImageKey);
  }

  Future<void> setUserProfileImage(String profileImage) async {
    await _preferences?.setString(
      AppConstants.userProfileImageKey,
      profileImage,
    );
  }

  // User Created At
  Future<String?> get userCreatedAt async {
    return _preferences?.getString(AppConstants.userCreatedAtKey);
  }

  Future<void> setUserCreatedAt(String createdAt) async {
    await _preferences?.setString(AppConstants.userCreatedAtKey, createdAt);
  }

  // Login setup method
  Future<void> login({
    required String userId,
    required String email,
    required String name,
    required String token,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? mobile,
    String? createdAt,
  }) async {
    await setLoggedIn(true);
    await setUserId(userId);
    await setUserEmail(email);
    await setUserName(name);
    await setAuthToken(token);
    if (firstName != null) await setUserFirstName(firstName);
    if (lastName != null) await setUserLastName(lastName);
    if (mobile != null) await setUserMobile(mobile);
    if (profileImage != null) await setUserProfileImage(profileImage);
    if (createdAt != null) await setUserCreatedAt(createdAt);
  }

  // Logout method
  Future<void> logout() async {
    await _preferences?.remove(AppConstants.isLoggedInKey);
    await _preferences?.remove(AppConstants.userIdKey);
    await _preferences?.remove(AppConstants.userEmailKey);
    await _preferences?.remove(AppConstants.userNameKey);
    await _preferences?.remove(AppConstants.authTokenKey);
    await _preferences?.remove(AppConstants.userFirstNameKey);
    await _preferences?.remove(AppConstants.userLastNameKey);
    await _preferences?.remove(AppConstants.userMobileKey);
    await _preferences?.remove(AppConstants.userProfileImageKey);
    await _preferences?.remove(AppConstants.userCreatedAtKey);
  }

  // Generic methods for other preferences
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    return _preferences?.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    return _preferences?.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<int?> getInt(String key) async {
    return _preferences?.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  Future<double?> getDouble(String key) async {
    return _preferences?.getDouble(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    return _preferences?.getStringList(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
