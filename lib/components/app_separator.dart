import 'package:flutter/material.dart';

class AppSeparator extends StatelessWidget {
  const AppSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 10.0,
      color: const Color(0xffF8F8F8),
    );
  }
}
