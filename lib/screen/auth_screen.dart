import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:report_app/providers/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  void switchMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      authProvider.login(email, password);
    } else {
      authProvider.signup(email, password);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
    if (!value.contains('@')) return 'البريد الإلكتروني غير صالح';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  void clearControllers() {
    _passwordController.clear();
    _emailController.clear();
    _confirmPasswordController.clear();
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 134, 152),
      appBar: AppBar(),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "البريد الإلكتروني",
                      filled: true,
                      fillColor: Color.fromARGB(255, 138, 157, 167),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      errorStyle: const TextStyle(
                          height: 1.2, fontSize: 12, color: Colors.red),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "كلمة المرور",
                      filled: true,
                      fillColor: Color.fromARGB(255, 138, 157, 167),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      errorStyle: const TextStyle(
                          height: 1.2, fontSize: 12, color: Colors.red),
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  if (_authMode == AuthMode.Signup) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: "تأكيد كلمة المرور",
                        filled: true,
                        fillColor: Color.fromARGB(255, 138, 157, 167),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 10),
                        errorStyle: const TextStyle(
                            height: 1.2, fontSize: 12, color: Colors.red),
                      ),
                      obscureText: true,
                      validator: _validateConfirmPassword,
                    ),
                  ],
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _submit,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 138, 157, 167),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        _authMode == AuthMode.Login ? "تسجيل دخول" : "تسجيل",
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(_authMode == AuthMode.Login
                          ? "ليس لديك حساب؟"
                          : "لديك حساب مسبقاً؟"),
                      TextButton(
                        onPressed: () {
                          switchMode();
                          clearControllers();
                        },
                        child: Text(_authMode == AuthMode.Login
                            ? "تسجيل"
                            : "تسجيل دخول"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
