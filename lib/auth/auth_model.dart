import 'package:flutter/material.dart';

// import 'auth_api.dart';

class AuthModel extends ChangeNotifier {
  // final _apiClient = AppClient();

  final loginTextController = TextEditingController();
  final passTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Введите логин и пароль';

      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    // final session = await _apiClient.auth(email: login, password: password);
    // _isAuthProgress = false;
    // _isAuthProgress = true;
    // notifyListeners();
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
