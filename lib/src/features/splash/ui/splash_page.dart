import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400)).then(
      (value) {
        setState(() {
          _visible = true;
        });
      },
    );
  }

  void _onAnimationEnd() {
    Future.delayed(const Duration(milliseconds: 300)).then(
      (value) {
        Modular.to.navigate('/auth/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(seconds: 2),
          onEnd: () {
            _onAnimationEnd();
          },
          child: Image.asset(
            AppImages.logo,
          ),
        ),
      ),
    );
  }
}
