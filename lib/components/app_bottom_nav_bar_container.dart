import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavBarContainer extends StatelessWidget {
  const AppBottomNavBarContainer({
    super.key,
    // required this.shadowVisible,
    this.padding,
    required this.child,
  });

  // final bool shadowVisible;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );

    // box shadow
    /* BoxDecoration(
      color: Get.theme.cardColor,
      boxShadow: [
        if (shadowVisible)
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0.0, -2.0),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
       ]); */
  }
}
