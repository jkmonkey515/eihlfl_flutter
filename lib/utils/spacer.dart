import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get verticalSpacer => SizedBox(height: toDouble());

  SizedBox get horizontalSpacer => SizedBox(width: toDouble());
}
