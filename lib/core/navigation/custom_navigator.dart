import 'package:flutter/material.dart';

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String ocrRoute = '/ocr';

  /// Provides a global context attached to the Navigator.
  ///
  /// This is safe to use for dialogs, snackbars, or provider lookups from
  /// service classes or other parts of the app that don't have a
  /// BuildContext. It will be null until the MaterialApp is built.
  static BuildContext? get appContext => navigatorKey.currentContext;

  static NavigatorState get navigator => navigatorKey.currentState!;

  static Future<T?> push<T extends Object?>(Widget page) {
    return navigator.push(MaterialPageRoute(builder: (_) => page));
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget page,
  ) {
    return navigator.pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget page,
    RoutePredicate predicate,
  ) {
    return navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigator.pop(result);
  }

  static void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }

  static bool canPop() {
    return navigator.canPop();
  }

  static Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigator.maybePop(result);
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushNamed(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigator.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigator.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  // Custom navigation methods
  static void goToHome() {
    pushNamedAndRemoveUntil(homeRoute);
  }

  static void goToLogin() {
    pushReplacementNamed(loginRoute);
  }

  static void goToProfile() {
    pushNamed(profileRoute);
  }

  static void goBack() {
    if (canPop()) {
      pop();
    }
  }
}
