import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final fToast = FToast();

void showToast(BuildContext context, String message) {
  closeToast();
  fToast
      .init(context)
      .showToast(child: Text(message), gravity: ToastGravity.SNACKBAR);
}

void closeToast() {
  fToast.removeCustomToast();
}

void navigate(BuildContext context, String route) {
  closeToast();
  Navigator.pushNamed(context, route);
}

void replace(BuildContext context, String route) {
  closeToast();
  Navigator.pushReplacementNamed(context, route);
}

void goToBack(BuildContext context) {
  closeToast();
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void close(BuildContext context) {
  Navigator.pop(context);
}
