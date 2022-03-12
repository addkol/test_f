import 'package:flutter/material.dart';
import 'auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/log.png'),
        ),
        const _FormWidget()
      ],
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: model?.loginTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              labelText: 'Введите логин',
              labelStyle: TextStyle(color: Colors.grey),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          child: TextField(
            controller: model?.passTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              labelText: 'Введите пароль',
              labelStyle: TextStyle(color: Colors.grey),
              isDense: true,
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
          ),
        ),
        const _ErrorMessageWidget(),
        const SizedBox(
          height: 20,
        ),
        const _AuthButtonWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Забыли пароль?',
                style: TextStyle(color: Colors.grey),
              ),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey)),
            ),
            const Text(
              '|',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Зарегистрироваться',
                style: TextStyle(color: Colors.grey),
              ),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.grey)),
            ),
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const CircularProgressIndicator()
        : const Text(
            'Войти',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
    return ElevatedButton(
      onPressed: () => onPressed,
      child: child,
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.blue[900]),
          backgroundColor: MaterialStateProperty.all(Colors.grey),
          fixedSize: MaterialStateProperty.all(const Size(260, 50)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Text(
        'errorMessage',
        style: TextStyle(fontSize: 17, color: Colors.redAccent),
      ),
    );
  }
}
