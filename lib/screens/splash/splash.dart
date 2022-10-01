import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.red.shade900,
                    Colors.grey.shade400,
                    Colors.teal.shade900,
                    Colors.blue.shade900,
                  ],
                ).createShader(bounds);
              },
              child: const Text(
                'PRELUDES',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 60.0,
                  letterSpacing: -7.0,
                ),
              ),
            ),
          ),
          Platform.isIOS
              ? const CupertinoActivityIndicator()
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
