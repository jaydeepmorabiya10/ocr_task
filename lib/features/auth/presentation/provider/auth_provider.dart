import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/models/login_response_model.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SharedPreferencesService sharedPreferencesService;

  AuthProvider({
    required this.loginUseCase,
    required this.sharedPreferencesService,
  });

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<String?> get userFirstName async =>
      await sharedPreferencesService.userFirstName;
  Future<String?> get userLastName async =>
      await sharedPreferencesService.userLastName;
  Future<String?> get userEmail async =>
      await sharedPreferencesService.userEmail;
  Future<String?> get userProfileImage async =>
      await sharedPreferencesService.userProfileImage;
  Future<String?> get userMobile async =>
      await sharedPreferencesService.userMobile;
  Future<String?> get userCreatedAt async =>
      await sharedPreferencesService.userCreatedAt;
  Future<String?> get userRole async =>
      await sharedPreferencesService.getSavedRole;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );
    await result.fold(
      (failure) {
        _errorMessage = failure.message;
        log("error==>$_errorMessage");
        _isAuthenticated = false;
      },
      (loginResponse) async {
        _isAuthenticated = true;
        _errorMessage = null;
        // Save user data
        final contact = loginResponse.data?.contact;
        if (contact != null) {
          await sharedPreferencesService.login(
            userId: contact.id.toString(),
            email: contact.email ?? '',
            name: '${contact.firstname ?? ''} ${contact.lastname ?? ''}'.trim(),
            token: loginResponse.data?.accessToken ?? '',
            firstName: contact.firstname,
            lastName: contact.lastname,
            profileImage: contact.profileImage,
            mobile: contact.phonenumber,
            createdAt: contact.createdAt,
          );
          await sharedPreferencesService.setSaveRole(contact.title ?? '');
        }
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    sharedPreferencesService.logout();
    _errorMessage = null;
    notifyListeners();
  }
}
