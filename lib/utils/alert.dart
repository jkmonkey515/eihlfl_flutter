import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A simple service for displaying alerts to the user
class AlertService {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
