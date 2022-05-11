import 'package:flutter/material.dart';
import './login.state.dart';
import '../todo/todo.page.dart';
import '../../services/auth.service.dart';
import '../../basestate/basestate.widget.dart';

class LoginPage extends StatelessWidget {
  final LoginPageStateProvider instance = LoginPageStateProvider(LoginPageState(username: "", password: ""));

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BaseStateWidget<AuthService, AuthState>(
                state: AuthService.instance,
                builder: (authService) {
                  return const SizedBox();
                },
                onError: (err) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      err.toString(),
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  );
                },
              ),
              TextField(
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                onChanged: instance.updateUsername,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: instance.updatePassword,
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                child: const Text("Login"),
                onPressed: () {
                  try {
                    AuthService.instance.logIn(
                      instance.state.username,
                      instance.state.password,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoPage(),
                      ),
                    );
                  } catch (err) {
                    // Fetch error if needed
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
