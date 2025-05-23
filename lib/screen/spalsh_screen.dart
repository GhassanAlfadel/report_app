import 'package:flutter/material.dart';
import 'package:characters/characters.dart';
import 'package:provider/provider.dart';
import 'package:report_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final word = "🪛🔧🔨💡";
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  late final List<String> characters;

  @override
  void initState() {
    super.initState();

    characters = word.characters.toList();

    for (int i = 0; i < characters.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      final animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn),
      );
      _controllers.add(controller);
      _animations.add(animation);
    }

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _controllers[i].forward();
    }

    await Future.delayed(const Duration(seconds: 1));
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.autilogin();
    if (auth.logedin) {
      Navigator.of(context).pushReplacementNamed("/home_screen");
    } else {
      Navigator.of(context).pushReplacementNamed("/auth_screen");
    }
// auth.logedin ? const HomeScreen() : const AuthScreen(),
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 134, 152),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(characters.length, (index) {
                return FadeTransition(
                  opacity: _animations[index],
                  child: Text(
                    characters[index],
                    style: const TextStyle(
                      fontSize: 64,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _animations.last,
              child: const Text(
                'Report App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
